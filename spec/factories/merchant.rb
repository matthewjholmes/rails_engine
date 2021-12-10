# frozen_string_literal: true

FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Company.name }
  end
end
