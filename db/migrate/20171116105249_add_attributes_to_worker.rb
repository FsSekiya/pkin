class AddAttributesToWorker < ActiveRecord::Migration[5.1]
  def change
    add_column :workers, :address, :string
    add_column :workers, :entrance_date, :date
    add_column :workers, :phone_number, :string
    add_column :workers, :birthday, :date
    add_column :workers, :bank_account, :string
    add_column :workers, :bank_branch, :string
    add_column :workers, :bank_kind, :integer
    add_column :workers, :bank_name, :string
    add_column :workers, :bank_number, :string
  end
end
