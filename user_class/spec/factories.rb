# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    id { Faker::IDNumber.valid }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@example.com" }
    age { rand(1...100) }
    address { Faker::Address.street_address }

    initialize_with { attributes }
  end
end
