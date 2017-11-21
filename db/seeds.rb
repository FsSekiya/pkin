

def calculate_random_entrance_date
  Date.new(
    (2000..2016).random,
    (1..12).random,
    (1..28).random
  )
end

if Rails.env.development?
  o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten

  company = Company.create(name: 'カウンティア株式会社')

  CompanySetting.create(
    company_id: company.id,
    approve_auto_prepayment: 'auto_prepayment_approved',
    prepayment_allowed_percentage: rand(100),
    wage_calculation_time_unit: 60
  )

  5.times do
    Company.create(name: ForgeryJa(:name).company_name)
  end

  5.times do
    Branch.create(
      name: ForgeryJa(:address).city,
      code: (0...5).map { o[rand(o.length)] }.join,
      company_id: company.id)
  end

  Customer.create(
    name: "test",
    email: "to.be.mr.all.rounder@gmail.com",
    password: '12341234',
    password_confirmation: '12341234',
    company_id: company.id)

  name_forgery = ForgeryJa(:name)
  address_forgery = ForgeryJa(:address)
  mobile_forgery = ForgeryJa(:mobile)
  email_forgery = Forgery(:email)
  100.times do
    entrance_date = calculate_random_entrance_date
    bank_account = (0...7).map { rand(10).to_s }.join
    Worker.create(
      name: name_forgery.full_name,
      furigana: name_forgery.full_name(to: ForgeryJa::HIRA),
      password: '12341234',
      password_confirmation: '12341234',
      uid: Branch.first.code + (0...5).map { o[rand(o.length)] }.join,
      branch_id: Branch.first.id,
      hourly_pay: 1200,
      address: address_forgery.full_address,
      phone_number: mobile_forgery.phone_number,
      entrance_date: entrance_date,
      birthday: entrance_date - (20..40).random.year,
      bank_account: bank_account,
      email: email_forgery.address
    )
  end
end
