class Customer::ApplyController < Customer::ApplicationController
  def index; end

  def show
    today = Time.zone.today + params[:diff].to_i.month
    worker_ids = Worker.where(branch_id: params[:id]).map(&:id)
    applications = PrepaymentApplication.where(
      created_at: today.beginning_of_month..today.end_of_month,
      worker_id: worker_ids
    )
    @prepayment_total = applications.sum(:amount)
    @payment_total = WorkingRecord.where(
      start_at: today.beginning_of_month..today.end_of_month,
      worker_id: worker_ids
    ).sum(:payment)
    @current_month = today.strftime('%Y年%m月')
    @branch = Branch.unscoped.find(params[:id])
    @deposit = Deposit.where(company_id: @branch.id).sum(:amount)
    @remaining_deposit = @deposit - @prepayment_total
    logger.debug applications.first(30)
    @application_list = applications.first(30)
    # @application_list = [
    #   { id: 1, date: '2017年10月11日', applied_amount: 50_000, approved_amount: 30_000, payed_amount: 10_000 }
    # ]
  end
end
