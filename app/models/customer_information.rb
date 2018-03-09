class CustomerInformation < ApplicationRecord
  belongs_to :customer
  enum status: %i[preparing published archived]
end
