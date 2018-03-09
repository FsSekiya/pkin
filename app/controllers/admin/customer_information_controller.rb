class Admin::CustomerInformationController < Admin::ApplicationController
  layout 'admin'

  def new
    @information = CustomerInformation.new
  end

  def create
    @information = CustomerInformation.new(information_params.merge(customer_id: 1))
    redirect_to admin_customer_information_index_path, flash: { notice: '保存しました' } if @information.save
  end

  def index
    @information_list = CustomerInformation.limit(5)
  end

  private

  def information_params
    params.require(:customer_information).permit(:title, :content)
  end
end
