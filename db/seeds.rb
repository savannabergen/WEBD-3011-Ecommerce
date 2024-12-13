require 'faker'

categories = [
  { name: 'T-Shirts', description: 'Casual and comfortable tees' },
  { name: 'Hoodies', description: 'Cozy and stylish hoodies' },
  { name: 'Jeans', description: 'Classic and trendy jeans' },
  { name: 'Shoes', description: 'Sneakers and boots for every occasion' }
]

categories_with_ids = Category.create!(categories)

100.times do |i|
  product = {
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.within(range: 1000..50000),
    active: true,
    category_id: Category.pluck(:id).sample
  }

  begin
    Product.create!(product)
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating product: #{e.message}"
  end
end

Product.all.each do |product|
  sizes = [ 'S', 'M', 'L', 'XL' ]
  sizes.each do |size|
  stock = {
  size: size,
  amount: Faker::Number.within(range: 1..100),
  product_id: Product.pluck(:id).sample
  }
  Stock.create!(stock)
  end
end

50.times do
  order = Order.new(
    customer_email: Faker::Internet.email,
    fulfilled: false,
    total: Faker::Number.within(range: 10..100)
  )
  order.save!
end

50.times do
  order = Order.new(
    customer_email: Faker::Internet.email,
    fulfilled: true,
    total: Faker::Number.within(range: 10..100),
  )
  order.save!
end
