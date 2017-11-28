class Customer::ApplyController < Customer::ApplicationController
  def index; end

  def show
    @current_month = (Time.zone.today + params[:diff].to_i.month).strftime('%Y年%m月')
    @branch = Branch.unscoped.find(params[:id])
    @application_list = [
      { id: 1, date: '2017年10月11日', applied_amount: 50_000, approved_amount: 30_000, payed_amount: 10_000 }
    ]
  end
end
