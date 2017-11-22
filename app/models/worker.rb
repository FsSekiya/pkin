class Worker < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         authentication_keys: [:uid], case_insensitive_keys: [:uid]
  belongs_to :branch
  has_many :working_records, dependent: :destroy

  has_paper_trail(
    ignore: %i[
      reset_password_token
      reset_password_sent_at
      remember_created_at
      sign_in_count
      current_sign_in_at
      last_sign_in_at
      current_sign_in_ip
      last_sign_in_ip
      updated_at
    ]
  )

  def confirmed_at
    Time.now.utc
  end
end
