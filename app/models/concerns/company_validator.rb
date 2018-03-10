module CompanyValidator
  extend ActiveSupport::Concern

  # もう少しちゃんと考える
  included do
    validates :name, presence: true
    validates :tel, presence: true
    validates :email, presence: true
    validates :email, email: true
    validates :address, presence: true
    validates :zip_code, presence: true
    validates :zip_code, format: { with: /\A\d{7}\z/ }
  end
end
