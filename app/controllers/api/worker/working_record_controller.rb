class Api::Worker::WorkingRecordController < Api::Worker::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api!

  def amount
    # p current_api_worker_worker
    render json: { amount: "¥#{10_000.to_s(:delimited)}-" }
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
    worker = current_api_worker_worker
    result_working_record = worker.start_work!
    render json: result_working_record
  end

  def finish
    worker = current_api_worker_worker
    result_working_record = worker.finish_work!
    render json: result_working_record
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
end
