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
