class Customers::WorkerController < Customers::ApplicationController
  layout 'customers'

  def new
    if params[:branch_id].blank?
      flash[:error] = '遷移が正しくありません'
      return redirect_to customers_dashboard_index_path
    end

    @worker = Worker.new(branch_id: params[:branch_id])
  end

  def create
    redirect_to customers_branch_path(1), flash: { notice: '変更しました' }
    # @worker = Worker.new(worker_params)
    # if @worker.save
    # else
    #   render :index
    # end
  end

  private

  def worker_params
    params.require(:worker).permit(:name, :email, :image, :branch_id)
  end
end
