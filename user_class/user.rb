class User
  @@VALID_ATR = %i(first_name last_name email age address)

  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, first_name:, last_name:, email:, **kwargs)
    info = {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email
    }
    if kwargs[:age]
      info.merge!({age: kwargs[:age]})
    end
    if kwargs[:address]
      info.merge!({address: kwargs[:address]})
    end

    @all << info
  end

  def count
    @all.size
  end

  def find(id)
    @all.find { |user| user if id == user[:id] }
  end

  def where(**kwargs)
    elements = []

    @all.each do |user|
      check = true
      kwargs.each do |atr, value|
        check = false unless user[atr] == value
      end
      elements << user if check
    end

    elements
  end

  def update(id:, **info_update)
    @all.map do |user|
      if id == user[:id]
        info_update.each do |atr, value_update|
          user[atr] = value_update if @@VALID_ATR.include?(atr)
        end
      end
    end
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
p users.all
p users.count
p users.find('0004')
p users.where(first_name: 'Axel')
p users.find('0020')
users.update(id: '0020', first_name: 'Artemis', age: 30, oh: 'new attribute')
p users.find('0020')
