require 'faker'

10.times do
  Category.create(name: Faker::Commerce.department, description: Faker::Lorem.paragraph)
end

10.times do
  Product.create(
  name: Faker::Commerce.product_name,
  description: Faker::Lorem.paragraph,
  price: Faker::Commerce.price,
  category_id: Category.pluck(:id).sample,
  active: true
  )
end

10.times do
  Order.create(
  customer_email: Faker::Internet.email,
  fulfilled: Faker::Boolean.boolean,
  total: Faker::Commerce.price,
  address: Faker::Address.full_address
  )
end
