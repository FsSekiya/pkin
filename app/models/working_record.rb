class WorkingRecord < ApplicationRecord
  belongs_to :worker

  def calculate_payment
    hours = (finish_at - start_at) / (60 * 60)
    self.payment = hours * hourly_pay
    payment
  end
end
