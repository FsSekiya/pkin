class Customer::InformationController < Customer::ApplicationController
  layout 'customer'

  def index
    @information_list = CustomerInformation.where(customer_id: current_customer.id)
  end
end
