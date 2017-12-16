class AddDeadlinedDateToWorkMonthlySummary < ActiveRecord::Migration[5.1]
  def change
    add_column :work_monthly_summaries, :summary_start_date, :date
    add_column :work_monthly_summaries, :summary_end_date, :date
  end
end
