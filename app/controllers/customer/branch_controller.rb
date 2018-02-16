class Customer::BranchController < Customer::ApplicationController
  def show
    @branch = Branch.unscoped.find(params[:id])
    @worker_list = Worker.where(branch_id: @branch.id).page(params[:page])
  end
end
