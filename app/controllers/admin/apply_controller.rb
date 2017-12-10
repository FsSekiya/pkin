class Admin::ApplyController < Admin::ApplicationController
  layout 'admin'

  def index; end

  def csv
    csv_date = ''
    send_data(csv_date, filename: 'product3.csv')
  end
end
