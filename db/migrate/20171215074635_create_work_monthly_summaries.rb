class CreateWorkMonthlySummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :work_monthly_summaries, &:timestamps
  end
end
