class PrepaymentApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :prepayment, optional: true

  enum status: { pending: 0, approved: 1, rejected: 2 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
