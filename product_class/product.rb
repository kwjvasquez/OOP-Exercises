# frozen_string_literal: true

class Product
  VALID_ATR = %i[name value brand description quantity].freeze

  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, name:, value:, brand:, **opt_info)
    info = {
      id: id,
      name: name,
      value: value,
      brand: brand
    }
    info.merge!(description: opt_info[:description]) if opt_info[:description]
    info.merge!(quantity: opt_info[:quantity]) if opt_info[:quantity]

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
    product = find(id: id)

    return unless product

    info_update.each do |atr, value_update|
      product[atr] = value_update if VALID_ATR.include?(atr)
    end
  end

  def destroy(id:)
    @all.delete_if { |product| id == product[:id] }
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

product3_info = {
  id: 'T0051',
  name: 'MacBook Air 13p M1',
  value: 5_000_000,
  brand: 'Apple'
}
products.create(**product3_info)

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
