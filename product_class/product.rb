class Product
  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, name:, value:, brand:, **optional_info)
    info = {
      id: id,
      name: name,
      value: value,
      brand: brand
    }
    if optional_info[:description]
      info.merge!({description: optional_info[:description]})
    end
    if optional_info[:quantity]
      info.merge!({quantity: optional_info[:quantity]})
    end

    @all << info
  end
end

products = Product.new
puts "Products: #{products.all}"

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

puts "Products: #{products.all}"
