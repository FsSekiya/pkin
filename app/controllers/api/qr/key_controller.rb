class Api::Qr::KeyController < Api::Qr::ApplicationController
  def index
    aes_key = AesKeySet.last
    render json: { key: aes_key.key, iv: aes_key.iv }
  end
end
