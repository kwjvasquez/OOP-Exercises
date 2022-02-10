class User
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
p users.all
