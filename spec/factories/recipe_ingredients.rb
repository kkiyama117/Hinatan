# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient do
    recipes { nil }
    ingredients { nil }
  end
end
