class AddAttributesToWorker < ActiveRecord::Migration[5.1]
  def change
    add_column :workers, :address, :string
    add_column :workers, :entrance_date, :date
    add_column :workers, :phone_number, :string
    add_column :workers, :birthday, :date
    add_column :workers, :bank_account, :string
  end
end
