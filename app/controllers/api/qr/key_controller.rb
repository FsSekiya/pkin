class Api::Qr::KeyController < Api::Qr::ApplicationController
  def index
    render json: { key: 'passwordpasswordpasswordpassword', iv: 'drowssapdrowssap' }
  end
end
