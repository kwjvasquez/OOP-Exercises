# frozen_string_literal: true

require_relative "models/user"
require_relative "models/product"

users = User.new
products = Product.new

user1_info = {
  id: '0001',
  first_name: 'Axel',
  last_name: 'Ryzen',
  email: 'aryzen@example.com'
}
users.create(**user1_info)

user2_info = {
  id: '0004',
  first_name: 'Liliana',
  last_name: 'Intel',
  email: 'lintel@example.com',
  age: 32
}
users.create(**user2_info)

user3_info = {
  id: '0009',
  first_name: 'Axel',
  last_name: 'Riot',
  email: 'ariot@example.com'
}
users.create(**user3_info)

user4_info = {
  id: '0020',
  first_name: 'Hiena',
  last_name: 'Intel',
  email: 'hintel@example.com',
  address: 'CR 4B # 7'
}
users.create(**user4_info)

product1_info = {
  id: 'T0001',
  name: 'iPhone 6s',
  value: 790_000,
  brand: 'Apple'
}
products.create(**product1_info)

product2_info = {
  id: 'T0010',
  name: 'REDMI 9C',
  value: 485_900,
  brand: 'Xiaomi',
  quantity: 50
}
products.create(**product2_info)

product3_info = {
  id: 'T0051',
  name: 'MacBook Air 13p M1',
  value: 5_000_000,
  brand: 'Apple'
}
products.create(**product3_info)

puts "Users: #{users.all}"
puts "Total users: #{users.count}"
puts "User searched: #{users.find('0004')}"
puts "Users matched: #{users.where(first_name: 'Axel')}"
puts "User current info: #{users.find('0020')}"
users.update(id: '0020', first_name: 'Artemis', age: 30, oh: 'new attribute')
puts "User update info: #{users.find('0020')}"
puts "Total users: #{users.count}"
users.destroy(id: '0020')
puts "Total users: #{users.count}"
puts "Users: #{users.all}"

puts "Products: #{products.all}"
puts "Total products: #{products.count}"
puts "Product searched: #{products.find(id: 'T0001')}"
puts "Product matched: #{products.where(brand: 'Apple')}"
puts "Product current info: #{products.find(id: 'T0001')}"
products.update(id: 'T0001', quantity: 15)
puts "Product info update: #{products.find(id: 'T0001')}"
puts "Total products: #{products.count}"
products.destroy(id: 'T0051')
puts "Total products: #{products.count}"
puts "products: #{products.all}"
