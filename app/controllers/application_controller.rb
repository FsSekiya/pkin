class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    customer_dashboard_index_path if resource.class == Customer
  end
end
