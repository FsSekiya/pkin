class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :code
      t.references :company, foreign_key: true

      t.timestamps
    end

    add_index :branches, [:code], unique: true
  end
end
