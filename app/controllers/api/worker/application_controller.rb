class Api::Worker::ApplicationController < Api::ApplicationController
  devise_token_auth_group :api, contains: [:api_worker_worker]
  before_action :authenticate_api!
end
