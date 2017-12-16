class WorkingRecord < ApplicationRecord
  belongs_to :worker
  belongs_to :work_monthly_summary, optional: true

  def calculate_payment
    hours = (finish_at - start_at) / (60 * 60)
    self.payment = hours * hourly_pay
    payment
  end
end
