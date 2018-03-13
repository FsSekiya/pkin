class Admin::CompanyController < Admin::ApplicationController
  layout 'admin'

  def index
    @companies = if params[:query].present?
                   Company.search(params[:query])
                 else
                   Company.all.page(params[:page])
                 end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to admin_company_index_path, flash: { notice: '新規作成しました' }
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to admin_company_index_path, flash: { notice: '変更しました' }
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :tel, :email, :zip_code,
                                    company_setting_attributes: %i[approve_auto_prepayment prepayment_allowed_percentage
                                                                   send_alert_amount wage_calculation_time_unit])
  end
end
