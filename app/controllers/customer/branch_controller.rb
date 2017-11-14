class Customer::BranchController < Customer::ApplicationController
  def show
    @branch = Branch.find(params[:id])
    @member_list = Worker.all
  end
end
