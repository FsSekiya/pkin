class CreateCompanySettings < ActiveRecord::Migration[5.1]
  def change
    create_table :company_settings do |t|
      t.references :company, foreign_key: true
      t.integer :approve_auto_prepayment, limit: 1
      t.integer :prepayment_allowed_percentage, limit: 1
      t.integer :wage_calculation_time_unit, limit: 1

      t.timestamps
    end
  end
end
