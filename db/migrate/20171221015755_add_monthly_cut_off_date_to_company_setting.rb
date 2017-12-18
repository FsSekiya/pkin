class AddMonthlyCutOffDateToCompanySetting < ActiveRecord::Migration[5.1]
  def change
    add_column :company_settings, :monthly_cut_off_date, :integer
  end
end
