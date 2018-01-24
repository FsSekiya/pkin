class Api::Customer::PrepaymentController < Api::ApplicationController
  def show
    worker = Worker.unscoped.find(params[:id])
    month_diff = params['month_diff']&.to_i || 0
    today = Time.zone.today + month_diff.month
    render json: {
      worker: worker,
      prepayment_applications: ActiveModelSerializers::SerializableResource.new(
        PrepaymentApplication.where(
          worker_id: worker.id,
          created_at: today.beginning_of_month..today.end_of_month
        ).order(:created_at),
        adapter: :json
      ).as_json[:prepayment_applications]
    }, adapter: :json
  end

  def update; end
end
