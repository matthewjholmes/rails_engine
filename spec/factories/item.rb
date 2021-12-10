# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
