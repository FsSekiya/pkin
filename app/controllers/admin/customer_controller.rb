class Admin::CustomerController < Admin::ApplicationController
  layout 'admin'

  def index
    @companies = if params[:query].present?
                   Company.search(params[:query])
                 else
                   Company.all
                 end
  end

  def login_customer
    sign_in Customer.find(params[:id]), scope: :admin
    session[:admin_login] = true
    redirect_to customer_dashboard_index_path
  end
end
