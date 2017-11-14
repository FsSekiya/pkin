class Customer::WorkerController < Customer::ApplicationController
  layout 'customer'

  def new
    @worker = Worker.new
  end
end
