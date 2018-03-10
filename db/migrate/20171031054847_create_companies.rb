class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.string :email
      t.string :zip_code

      t.timestamps
    end
  end
end
