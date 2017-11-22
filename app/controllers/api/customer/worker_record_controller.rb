class Api::Customer::WorkerRecordController < Api::ApplicationController
  def show
    worker = Worker.unscoped.find(params[:id])
    today = Time.zone.today
    render json: {
      worker: worker,
      working_records: ActiveModelSerializers::SerializableResource.new(
        WorkingRecord.where(worker_id: worker.id, start_at: today.beginning_of_month..today.end_of_month),
        adapter: :json
      ).as_json[:working_records]
    }, adapter: :json
  end

  def index
    res = {}
    row_data = ['2017/10/10', '17:00', '23:00', '1:00', '¥5000', '編集']
    (1..5).to_a.each do |x|
      res['row' + x.to_s] = row_data
    end

    render json: res
  end
end
