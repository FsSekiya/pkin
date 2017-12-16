class WorkMonthlySummary < ApplicationRecord
  belongs_to :worker
  belongs_to :monthly_payment
  has_many :working_record, dependent: :nullify
end
