
class Api::Worker::ApplyController < Api::Worker::ApplicationController
  protect_from_forgery with: :null_session

  def create
    worker = current_api_worker_worker
    application = worker.apply_prepayment(params[:amount].to_i)
    render json: application
  end
end
