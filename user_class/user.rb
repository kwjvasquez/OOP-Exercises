class User
  attr_reader :all

  def initialize
    @all = []
  end
end

users = User.new
p users.all
