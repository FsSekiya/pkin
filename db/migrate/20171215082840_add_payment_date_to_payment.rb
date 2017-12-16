class AddPaymentDateToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :payment_date, :date
  end
end
