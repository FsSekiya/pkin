class Company < ApplicationRecord
  has_one :company_setting, dependent: :destroy
  has_many :branches, dependent: :destroy
end
