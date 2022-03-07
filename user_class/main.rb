# frozen_string_literal: true

require 'user'

users = User.new

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
