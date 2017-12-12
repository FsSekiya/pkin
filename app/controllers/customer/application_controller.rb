class Customer::ApplicationController < ApplicationController
  devise_group :customer, contains: [:customer]
  before_action :authenticate
  layout 'customer'

  def authenticate
    redirect_to root_path unless customer_signed_in?
    @admin_login = true if admin_signed_in? || session[:admin_login]
  end
end
