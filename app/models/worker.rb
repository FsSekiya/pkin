class Worker < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         authentication_keys: [:uid], case_insensitive_keys: [:uid]

  belongs_to :branch
  has_many :working_records, dependent: :destroy
  belongs_to :current_working_record, class_name: 'WorkingRecord', optional: true

  delegate :company, to: :branch

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
    Time.now.in_time_zone
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

  def apply_prepayment(amount)
    amount = amount.to_i
    if prepayable_amount * (company.prepayment_allowed_percentage / 100.0) < amount
      raise 'prepayment not allowed'
    end
    PrepaymentApplication.create(amount: amount, worker: self)
  end

  def last_settlement_date
    latest_paid_summary =
      WorkMonthlySummary.joins(:monthly_payment)
                        .order(summary_end_date: :desc)
                        .first

    latest_paid_summary&.summary_end_date
  end

  def prepayable_amount
    last_regular_deadline_date = last_settlement_date

    prepayment_apps = PrepaymentApplication.where(worker: self)
    prepayment_apps = prepayment_apps.where('created_at > ?', last_regular_deadline_date) if last_regular_deadline_date

    working_records = WorkingRecord.where(worker: self)
    working_records = working_records.where('created_at > ?', last_regular_deadline_date) if last_regular_deadline_date

    current_applied_amount = prepayment_apps.pluck(:amount).sum
    total_to_be_earned = working_records.pluck(:payment).sum

    total_to_be_earned - current_applied_amount
  end
end
