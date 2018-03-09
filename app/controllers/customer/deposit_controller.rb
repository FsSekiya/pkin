class Customer::DepositController < Customer::ApplicationController
  layout 'customer'

  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = Deposit.new(deposit_params.merge(company_id: 1))
    redirect_to customer_deposit_index_path, flash: { notice: '保存しました' } if @deposit.save
  end

  def index; end

  def deposit_params
    params.require(:deposit).permit(:company_id, :amount)
  end
end
