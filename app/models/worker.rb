class Worker < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         authentication_keys: [:uid], case_insensitive_keys: [:uid]
  belongs_to :branch

  def confirmed_at
    Time.now.utc
  end
end
