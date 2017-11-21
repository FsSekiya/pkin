class Customer::BranchController < Customer::ApplicationController
  def show
    @branch = Branch.unscoped.find(params[:id])
    @member_list =
      Worker.select('workers.*, branches.name as branch_name')
            .joins(:branch).where(branch_id: @branch.id)
            .page(params[:page])
  end
end
