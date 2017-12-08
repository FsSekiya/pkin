class Api::Worker::ApplicationController < Api::ApplicationController
  devise_group :worker, contains: [:worker]

end
