class Customer::ApplicationController < ApplicationController
  devise_group :customer, contains: [:customer]
  before_action :authenticate
  layout 'customer'

  protected

  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
