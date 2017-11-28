class Api::Worker::WorkingRecordController < Api::Worker::ApplicationController
  def amount
    render json: { amount: "¥#{10_000.to_s(:delimited)}-" }
  end
end
