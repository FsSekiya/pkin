class Api::Worker::ApplicationController < Api::ApplicationController
  devise_token_auth_group :api, contains: [:api_worker_worker]
  before_action :authenticate_api!

  private

  def pretty_print_currency_amount(amount, tailer: '')
    "¥#{amount.to_i.to_s(:delimited)}#{tailer}"
  end
end
