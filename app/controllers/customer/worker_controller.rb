class Customer::WorkerController < Customer::ApplicationController
  layout 'customer'

  def new
    @worker = Worker.new(branch_id: params[:branch_id])
  end

  def create
    redirect_to customer_branch_path(1), flash: { notice: '変更しました' }
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
