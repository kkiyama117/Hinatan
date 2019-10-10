# frozen_string_literal: true

# Recipe-Ingredient
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
end
