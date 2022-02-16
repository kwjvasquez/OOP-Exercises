class Product
  VALID_ATR = %i(name value brand description quantity)

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

  def count
    @all.size
  end

  def find(id:)
    @all.find { |product| id == product[:id] }
  end

  def where(**filters)
    products = []

    @all.each do |product|
      check = true
      filters.each do |atr, value|
        check = false unless product[atr] == value
      end
      products << product if check
    end

    products
  end

  def update(id:, **info_update)
    @all.map do |product|
      if id == product[:id]
        info_update.each do |atr, value_update|
          product[atr] = value_update if VALID_ATR.include?(atr)
        end
      end
    end
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

product1_info = {
  id: 'T0051',
  name: 'MacBook Air 13p M1',
  value: 5_000_000,
  brand: 'Apple'
}
products.create(**product1_info)

puts "Products: #{products.all}"
puts "Total products: #{products.count}"
puts "Product searched: #{products.find(id: 'T0001')}"
puts "Product matched: #{products.where(brand: 'Apple')}"
puts "Product current info: #{products.find(id: 'T0001')}"
products.update(id: 'T0001', quantity: 15)
puts "Product info update: #{products.find(id: 'T0001')}"
