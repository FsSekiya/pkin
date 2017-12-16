class RemoveStatusFromPrepaymentApplication < ActiveRecord::Migration[5.1]
  def change
    remove_column :prepayment_applications, :status, :string
  end
end
