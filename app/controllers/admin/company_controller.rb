class Admin::CompanyController < Admin::ApplicationController
  layout 'admin'

  def index
    @companies = if params[:query].present?
                   Company.search(params[:query])
                 else
                   Company.all
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

  def edit; end

  def update; end

  private

  def company_params
    params.require(:company).permit(:name, :address, :tel, :email, :zip_code,
                                    company_setting_attributes: %i[approve_auto_prepayment prepayment_allowed_percentage
                                                                   send_alert_amount wage_calculation_time_unit])
  end
end
