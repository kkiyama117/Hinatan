# frozen_string_literal: true

# Recipe
class Recipe < ApplicationRecord
  # Roles
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
end
