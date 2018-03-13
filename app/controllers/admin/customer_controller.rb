class Admin::CustomerController < Admin::ApplicationController
  layout 'admin'

  def index
    @customers = if params[:query].present?
                   Customer.search(params[:query])
                 else
                   Customer.all.includes(:company).page(params[:page])
                 end
  end

  def create
    password = SecureRandom.hex(5)
    @customer = Customer.new(customer_params.merge(password: password))

    if @customer.save
      redirect_to admin_customer_index_path, flash: { notice: '新規作成しました' }
    else
      render :new
    end
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to admin_customer_index_path, flash: { notice: '変更しました' }
    else
      render :edit
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def login_customer
    sign_in Customer.unscoped.find(params[:id]), scope: :admin
    session[:admin_login] = true
    redirect_to customer_dashboard_index_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :charged_name, :company_id, :email)
  end
end
