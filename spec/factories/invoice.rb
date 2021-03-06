# frozen_string_literal: true

FactoryBot.define do
  factory :invoice, class: Invoice do
    association :customer

    status { ['cancelled', 'completed', 'in progress'].sample }
  end
end
