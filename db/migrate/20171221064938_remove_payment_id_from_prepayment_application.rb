class RemovePaymentIdFromPrepaymentApplication < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :prepayment_applications, :payments
    remove_column :prepayment_applications, :payment_id, :string
  end
end
