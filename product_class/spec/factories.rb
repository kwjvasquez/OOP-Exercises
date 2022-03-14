# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :product do
    id { Faker::Code.asin }
    name { Faker::Commerce.product_name }
    value { Faker::Commerce.price }
    brand { Faker::Commerce.brand }
    description { "#{Faker::Commerce.material} - #{Faker::Commerce.vendor}" }
    quantity { rand(1..100) }
  end
end
