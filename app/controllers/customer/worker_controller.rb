class Customer::WorkerController < Customer::ApplicationController
  layout 'customer'

  def new
    if params[:branch_id].blank?
      flash[:error] = '遷移が正しくありません'
      return redirect_to customer_dashboard_index_path
    end

    @worker = Worker.new(branch_id: params[:branch_id])
  end

  def create
    # TODO: uidをちゃんとセットする
    # TODO: passwordどうすんの？
    @worker = Worker.new(worker_params.merge(
                           password: worker_params[:phone_number],
                           uid: '12341234'
    ))

    if @worker.save
      redirect_to customer_branch_path(worker_params[:branch_id]), flash: { notice: '保存しました' }
    else
      # TODO: エラー処理
      rendert :new
    end
  end

  private

  def worker_params
    params.require(:worker)
          .permit(:name, :email, :image, :branch_id,
                  :name, :entrance_date, :hourly_pay, :birthday, :address, :phone_number,
                  :bank_name, :bank_branch, :bank_kind, :bank_number)
  end
end
