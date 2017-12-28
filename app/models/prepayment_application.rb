class PrepaymentApplication < ApplicationRecord
  belongs_to :worker
  belongs_to :prepayment, optional: true

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  def status
    # (IMO)
    # rejected_at, approved_at のようなtimestampを持つようにして、
    # それらで状態を管理するほうが、いつ状態が変更されたが追いやすくてお勧めです
    return :rejected if rejected?
    return :approved if prepayment
    :waiting
  end
end
