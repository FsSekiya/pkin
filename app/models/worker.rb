class Worker < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         authentication_keys: [:uid], case_insensitive_keys: [:uid]
  belongs_to :branch
  has_many :working_records, dependent: :destroy
  belongs_to :current_working_record, class_name: 'WorkingRecord', optional: true

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

  def working?
    !current_working_record.nil?
  end

  def confirmed_at
    Time.now.utc
  end

  def start_work!
    working_record = nil
    transaction do
      working_record = WorkingRecord.create(
        start_at: Time.current,
        hourly_pay: hourly_pay,
        worker: self
      )
      self.current_working_record = working_record
      save
    end
    working_record
  end

  def finish_work!
    working_record = current_working_record
    transaction do
      working_record.finish_at = Time.current
      working_record.calculate_payment
      working_record.save
      self.current_working_record = nil
      save
    end
    working_record
  end
end
