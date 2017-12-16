#!/usr/bin/env ruby

class Api::Worker::ApplyController < Api::Worker::ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_api!

  def create
    worker = current_api_worker_worker
    application = worker.apply_prepayment(params[:amount])
    render json: application
  end
end
