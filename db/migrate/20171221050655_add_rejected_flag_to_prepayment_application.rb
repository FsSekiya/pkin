class AddRejectedFlagToPrepaymentApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :prepayment_applications, :rejected, :bool, null: false, default: false
  end
end
