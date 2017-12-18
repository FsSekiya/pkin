class WorkingRecord < ApplicationRecord
  belongs_to :worker
  belongs_to :work_monthly_summary, optional: true

  def calculate_payment
    hours = hours_worked
    self.payment = hours * hourly_pay
    payment
  end

  def hours_worked
    (finish_at - start_at) / (60 * 60)
  end
end
