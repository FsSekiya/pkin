class Customer::BranchController < Customer::ApplicationController
  def show
    @branch = Branch.find(params[:id])
    @member_list = @branch.workers
  end
end
