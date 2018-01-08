require 'base64'
require 'openssl'

class Api::Worker::WorkingRecordController < Api::Worker::ApplicationController
  skip_before_action :verify_authenticity_token

  def prepayable_amount
    worker = current_api_worker_worker
    worker.prepayable_amount
  end

  def amount
    ret = prepayable_amount
    render json: { amount: pretty_print_currency_amount(ret) }
  end

  # 2017/12/16 Yuki-Inoue:
  # routes から参照するメソッドに ? って付与できるんでしたっけ？
  # なんか気持ち悪いので、 `working?` に変更しろと叱ってくるチェックを
  # disable します。
  #
  # rubocop:disable Naming/PredicateName
  def is_working
    worker = current_api_worker_worker
    render json: { bool_value: worker.working? }
  end
  # rubocop:enable Naming/PredicateName

  def start
    data = time_data

    if data.match?(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}\+0900$/)
      worker = current_api_worker_worker
      result_working_record = worker.start_work!(Time.zone.parse(data))
      render json: result_working_record
    else
      render json: { message: 'データ形式が不正です' }, status: :bad_request
    end
  end

  def finish
    data = time_data

    if data.match?(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}\+0900$/)
      worker = current_api_worker_worker
      result_working_record = worker.finish_work!(Time.zone.parse(data))
      render json: result_working_record
    else
      render json: { message: 'データ形式が不正です' }, status: :bad_request
    end
  end

  def paid_amounts
    diff_raw = params['diff'].to_i
    render(json: { error: '500 error' }, status: 500) && return unless diff_raw
    ret = compute_paid_amounts_responce(diff_raw)
    render json: ret
  end

  private

  def time_data
    encrypted = Base64.decode64(params[:time])

    cipher = OpenSSL::Cipher.new('aes-256-cbc')

    aes_key = AesKeySet.last

    cipher.padding = 1
    cipher.key = aes_key.key
    cipher.iv = aes_key.iv

    decrypted = ''
    decrypted << cipher.update(encrypted)
    decrypted << cipher.final
    decrypted
  rescue
    ''
  end

  # 2017/12/21 Yuki INOUE:
  #   どうしても長くなってしまうので、 Metrics のチェックをオフにします。
  #
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Style/FormatStringToken
  def compute_paid_amounts_responce(diff)
    time_format = '%Y/%m/%d'
    diff = diff.to_i

    worker = current_api_worker_worker
    iteration_summary = worker.iteration_summary(diff)

    working_records = iteration_summary[:working_records]

    cells = []
    cells << { 'level' => 0,
               'field' => '累計労働時間',
               'value' => format('%03d時間', iteration_summary[:total_work_hours]) }

    cells += working_records.map do |r|
      { 'level' => 1,
        'field' => r.start_at.strftime(time_format),
        'value' => format('%.1f時間', r.hours_worked) }
    end

    cells << { 'level' => 0,
               'field' => '累計給与額',
               'value' => pretty_print_currency_amount(iteration_summary[:total_salary]) }

    cells += working_records.map do |r|
      { 'level' => 1,
        'field' => r.start_at.strftime(time_format),
        'value' => pretty_print_currency_amount(r.payment) }
    end

    prepayment_applications = iteration_summary[:prepayment_applications]
    total_applied = iteration_summary[:total_applied]

    cells << { 'level' => 0,
               'field' => '支払済み額',
               'value' => pretty_print_currency_amount(total_applied) }

    cells += prepayment_applications.map do |a|
      { 'level' => 1,
        'field' => a.created_at.strftime(time_format),
        'value' => pretty_print_currency_amount(a.amount) }
    end

    salary_paid_normally = iteration_summary[:salary_paid_normally]

    cells << { 'level' => 0,
               'field' => '次回支給見込額',
               'value' => pretty_print_currency_amount(salary_paid_normally) }

    prepayable_amount = iteration_summary[:prepayable_amount]
    {
      'applicable_amount_entry' => {
        'field' => '申請可能額',
        'value' => pretty_print_currency_amount(prepayable_amount, tailer: '-')
      },
      'accordion_cells' => cells
    }
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Style/FormatStringToken
end
