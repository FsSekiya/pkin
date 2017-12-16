class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :type
      t.integer :status
      t.integer :amount
      t.references :worker, foreign_key: true

      t.timestamps
    end
  end
end
