class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits do |t|
      t.references :company, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
