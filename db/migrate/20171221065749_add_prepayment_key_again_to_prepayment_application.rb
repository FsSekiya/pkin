class AddPrepaymentKeyAgainToPrepaymentApplication < ActiveRecord::Migration[5.1]
  def change
    add_reference :prepayment_applications, :prepayment, foreign_key: { to_table: :payments }
  end
end
