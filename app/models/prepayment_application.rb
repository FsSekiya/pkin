class PrepaymentApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :prepayment, optional: true

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  def status
    return :rejected if rejected?
    return :approved if prepayment
    :waiting
  end
end
