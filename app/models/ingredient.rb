# frozen_string_literal: true

# Ingredients for recipe
class Ingredient < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
end
