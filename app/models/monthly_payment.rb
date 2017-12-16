class MonthlyPayment < Payment
  has_one :work_monthly_summary, dependent: :destroy
end
