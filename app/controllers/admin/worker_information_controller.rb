class Admin::WorkerInformationController < Admin::ApplicationController
  layout 'admin'

  def new
    @information = WorkerInformation.new
  end

  def create
    @information = WorkerInformation.new(information_params.merge(worker_id: 1))
    redirect_to admin_worker_information_index_path, flash: { notice: '保存しました' } if @information.save
  end

  def index
    @information_list = WorkerInformation.limit(5)
  end

  private

  def information_params
    params.require(:worker_information).permit(:title, :content)
  end
end
