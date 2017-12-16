class Prepayment < Payment
  has_many :prepayment_applications, dependent: :nullify
end
