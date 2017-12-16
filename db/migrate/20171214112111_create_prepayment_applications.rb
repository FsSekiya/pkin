class CreatePrepaymentApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :prepayment_applications do |t|
      t.integer :amount, null: false
      t.integer :status, null: false
      t.references :worker, foreign_key: true, null: false

      t.timestamps
    end
  end
end
