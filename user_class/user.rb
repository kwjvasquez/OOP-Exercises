# frozen_string_literal: true

class User
  VALID_ATR = %i[first_name last_name email age address].freeze

  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, first_name:, last_name:, email:, **opt_info)
    info = {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email
    }
    info.merge!(age: opt_info[:age]) if opt_info[:age]
    info.merge!(address: opt_info[:address]) if opt_info[:address]

    @all << info
  end

  def count
    @all.size
  end

  def find(id)
    @all.find { |user| user if id == user[:id] }
  end

  def where(**filters)
    elements = []

    @all.each do |user|
      check = true
      filters.each do |atr, value|
        check = false unless user[atr] == value
      end
      elements << user if check
    end

    elements
  end

  def update(id:, **info_update)
    user = find(id)

    return unless user

    info_update.each do |atr, value_update|
      user[atr] = value_update if VALID_ATR.include?(atr)
    end
  end

  def destroy(id:)
    @all.delete_if { |user| id == user[:id] }
  end
end

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
