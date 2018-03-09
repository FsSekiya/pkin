

def calculate_random_entrance_date
  Date.new(
    (2000..2016).random,
    (1..12).random,
    (1..28).random
  )
end

o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten

if ENV['SEED_DATA'] || Rails.env.development?
  company = Company.create(name: 'カウンティア株式会社')

  CompanySetting.create(
    company_id: company.id,
    approve_auto_prepayment: 'auto_prepayment_approved',
    prepayment_allowed_percentage: rand(100),
    wage_calculation_time_unit: 60,
    monthly_cut_off_date: 15
  )

  5.times do
    Company.create(name: ForgeryJa(:name).company_name)
  end

  5.times do |i|
    Branch.create(
      name: ForgeryJa(:address).city,
      code: '1234' + i.to_s,
      company_id: company.id
    )
  end

  Customer.create(
    name: 'test',
    email: 'to.be.mr.all.rounder@gmail.com',
    password: '12341234',
    password_confirmation: '12341234',
    company_id: company.id
  )

  Customer.all.each do |customer|
    20.times do
      CustomerInformation.create(
        customer_id: customer.id,
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        published_date: Faker::Time.between(DateTime.now - 4.months, DateTime.now)
      )
    end
  end

  name_forgery = ForgeryJa(:name)
  address_forgery = ForgeryJa(:address)
  mobile_forgery = ForgeryJa(:mobile)
  email_forgery = Forgery(:email)
  100.times do |i|
    entrance_date = calculate_random_entrance_date
    bank_account = (0...7).map { rand(10).to_s }.join
    Worker.create(
      name: name_forgery.full_name,
      furigana: name_forgery.full_name(to: ForgeryJa::HIRA),
      password: '12341234',
      password_confirmation: '12341234',
      uid: Branch.first.code + (1234 + i).to_s,
      branch_id: Branch.first.id,
      hourly_pay: rand(8..13) * 100,
      address: address_forgery.full_address,
      phone_number: mobile_forgery.phone_number,
      entrance_date: entrance_date,
      birthday: entrance_date - (20..40).random.year,
      bank_account: bank_account,
      bank_number: bank_account,
      bank_name: ForgeryJa(:address).street_name,
      bank_branch: 'カウンティアバンク',
      bank_kind: rand(0..1),
      email: email_forgery.address
    )
  end
  Worker.all.each do |worker|
    10.times do
      date = Faker::Time.between(DateTime.now - 4.months, DateTime.now)
      working_time = rand(1..8).hour
      WorkingRecord.create(
        worker_id: worker.id,
        start_at: date,
        finish_at: date + working_time,
        hourly_pay: worker.hourly_pay,
        payment: (worker.hourly_pay.to_i * (working_time / 3600.0).round(2)).to_i
      )
      WorkerInformation.create(
        worker_id: worker.id,
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        published_date: Faker::Time.between(DateTime.now - 4.months, DateTime.now)
      )
    end
  end

  Worker.all.each do |worker|
    50.times do
      num_apps = rand(1..3)
      apps = (0...num_apps).map do
        date = Faker::Time.between(DateTime.now - 4.months, DateTime.now)
        amount = rand(100..1000)
        PrepaymentApplication.create(
          worker: worker,
          created_at: date,
          amount: amount
        )
      end
      Prepayment.create(worker: worker, prepayment_applications: apps)
    end
  end

  Admin.create(
    name: 'test',
    email: 'to.be.mr.all.rounder@gmail.com',
    password: '12341234',
    password_confirmation: '12341234'
  )

  Deposit.create(
    amount: 10_000_000
  )
end
