class Api::Customer::WorkerRecordController < Api::ApplicationController
  def show
    worker = Worker.unscoped.find(params[:id])
    month_diff = params['month_diff']&.to_i || 0
    today = Time.zone.today + month_diff.month
    render json: {
      worker: worker,
      working_records: ActiveModelSerializers::SerializableResource.new(
        WorkingRecord.where(worker_id: worker.id,
                            start_at: today.beginning_of_month..today.end_of_month).order(:start_at),
        adapter: :json
      ).as_json[:working_records]
    }, adapter: :json
  end
end
