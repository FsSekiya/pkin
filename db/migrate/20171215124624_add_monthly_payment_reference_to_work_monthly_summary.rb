class AddMonthlyPaymentReferenceToWorkMonthlySummary < ActiveRecord::Migration[5.1]
  def change
    add_reference :work_monthly_summaries, :monthly_payment, foreign_key: { to_table: :payments }
  end
end
