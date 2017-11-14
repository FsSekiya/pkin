class Customer::RecordController < Customer::ApplicationController
  def index; end

  def show
    @branch = Branch.find(params[:id])
  end
end
