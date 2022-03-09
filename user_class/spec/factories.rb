# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    id { Faker::IDNumber.valid }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email(name: first_name) }
    age { rand(1...100) }
    address { Faker::Address.street_address }
  end
end
