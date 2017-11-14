
if Rails.env.development?
  Customer.create(
    name: "test",
    email: "to.be.mr.all.rounder@gmail.com",
    password: '12341234',
    password_confirmation: '12341234'
  )
end
