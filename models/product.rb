# frozen_string_literal: true

class Product
  VALID_ATR = %i[name value brand description quantity].freeze

  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, name:, value:, brand:, **opt_info)
    return if find(id: id)

    info = {
      id: id,
      name: name,
      value: value,
      brand: brand
    }
    info.merge!(description: opt_info[:description]) if opt_info[:description]
    info.merge!(quantity: opt_info[:quantity]) if opt_info[:quantity]
    @all << info

    info
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

