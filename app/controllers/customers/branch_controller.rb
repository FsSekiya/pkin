class Customers::BranchController < Customers::ApplicationController
  def show
    @branch = Branch.unscoped.find(params[:id])
    @member_list = @branch.workers.page(params[:page])
  end
end
