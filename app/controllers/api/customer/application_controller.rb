class Api::Customer::ApplicationController < Api::ApplicationController
  devise_group :customer, contains: [:customer]
  before_action :authenticate

  protected

  def authenticate
    return render json: {}, status: :not_found unless customer_signed_in?
  end
end
