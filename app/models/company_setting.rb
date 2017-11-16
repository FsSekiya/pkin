class CompanySetting < ApplicationRecord
  belongs_to :company

  enum approve_auto_prepayment: { auto_prepayment_not_approved: 0, auto_prepayment_approved: 1 }
end
