
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

  100.times do
    name = ForgeryJa(:name)
    Worker.create(
      name: name.full_name,
      furigana: name.full_name(to: ForgeryJa::HIRA),
      password: '12341234',
      password_confirmation: '12341234',
      uid: Branch.first.code + (0...5).map { o[rand(o.length)] }.join,
      branch_id: Branch.first.id,
      hourly_pay: 1200
    )
  end
end
