class Api::Worker::WorkingRecordController < Api::Worker::ApplicationController
  def amount
    render json: { amount: '¥10,000-' }
  end
end
