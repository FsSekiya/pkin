class AddPrepaymentKeyToPrepaymentApplication < ActiveRecord::Migration[5.1]
  def change
    add_reference :prepayment_applications, :payment, foreign_key: true
  end
end
