require 'base64'
require 'openssl'

class Api::Worker::WorkingRecordController < Api::Worker::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api!

  def amount
    worker = current_api_worker_worker
    ret = worker.prepayable_amount
    render json: { amount: "¥#{ret.to_s(:delimited)}-" }
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
    diff_raw = params['diff']
    render(json: { error: '500 error' }, status: 500) && return unless diff_raw

    ret = {
      'applicable_amount_entry' => {
        'field' => '申請可能額',
        'value' => "¥#{10_000.to_s(:delimited)}-"
      },
      'accordion_cells' => [
        { 'level' => 0,
          'field' => '累計労働時間',
          'value' => '000時間' },
        { 'level' => 1,
          'field' => '2017/11/10',
          'value' => '1.5 時間' },
        { 'level' => 1,
          'field' => '2017/11/09',
          'value' => '7.5 時間' },
        { 'level' => 0,
          'field' => '累計給与額',
          'value' => '¥30,000' },
        { 'level' => 1,
          'field' => '2017/11/10',
          'value' => '¥10,000' },
        { 'level' => 1,
          'field' => '2017/11/09',
          'value' => '¥20,000' },
        { 'level' => 0,
          'field' => '支払済み額',
          'value' => '¥30,000' },
        { 'level' => 1,
          'field' => '2017/11/08',
          'value' => '¥8,000' },
        { 'level' => 1,
          'field' => '2017/11/07',
          'value' => '¥12,000' },
        { 'level' => 0,
          'field' => '次回支給見込額',
          'value' => '¥20,000' },
        { 'level' => 0,
          'field' => '次回支給見込額',
          'value' => '¥20,000' }
      ]
    }

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
end
