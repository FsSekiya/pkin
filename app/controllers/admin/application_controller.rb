class Admin::ApplicationController < ApplicationController
  devise_group :admin, contains: [:admin]
  before_action :authenticate
  layout 'admin'

  protected

  def authenticate
    redirect_to root_path unless admin_signed_in?
  end
end
