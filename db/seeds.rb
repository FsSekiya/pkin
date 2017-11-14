
if Rails.env.development?
  company = Company.create(name: 'カウンティア株式会社')
  5.times do
    Company.create(name: ForgeryJa(:name).company_name)
  end

  5.times do
    Branch.create(
      name: ForgeryJa(:address).city,
      company_id: company.id
    )
  end

  Customer.create(
    name: "test",
    email: "to.be.mr.all.rounder@gmail.com",
    password: '12341234',
    password_confirmation: '12341234',
    company_id: company.id
  )
end
