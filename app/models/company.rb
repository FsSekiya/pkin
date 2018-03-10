class Company < ApplicationRecord
  include CompanyValidator

  has_one :company_setting, dependent: :destroy
  accepts_nested_attributes_for :company_setting

  has_many :branches, dependent: :destroy

  delegate :prepayment_allowed_percentage, :monthly_cut_off_date, to: :company_setting

  scope :search, lambda { |keyword|
    where('name like ?', "%#{sanitize_sql_like(keyword)}%")
  }

  def next_cut_off_date
    current = Date.current
    candidate = Date.new(current.year, current.month, monthly_cut_off_date)
    ret = candidate < current ? candidate.next_month : candidate
    ret
  end

  def salary_iteration(offset)
    offset = offset.to_i
    d = next_cut_off_date
    d += offset.months
    d.prev_month.next_day..d
  end
end
