class Company < ApplicationRecord
  has_one :company_setting, dependent: :destroy
  has_many :branches, dependent: :destroy

  scope :search, lambda { |keyword|
    where('name like ?', "%#{sanitize_sql_like(keyword)}%")
  }
end
