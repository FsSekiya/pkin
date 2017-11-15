class Customers::RecordController < Customers::ApplicationController
  def index; end

  def show
    @branch = Branch.unscoped.find(params[:id])
  end
end
