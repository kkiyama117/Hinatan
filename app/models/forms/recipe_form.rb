# frozen_string_literal: true

# Form for Recipe and Ingredient
class Form::RecipeForm < Form::Base
  def initialize(attributes = {})
    super attributes
    self.recipe = recipe
    self.ingredients = ingredients
  end

  concerning :RecipeBuilder do
    attr_accessor :recipes

    def recipe
      @recipe ||= Recipe.new
    end

    def recipe_attributes=(attributes)
      @recipe_attributes = Recipe.new attributes
    end
  end

  concerning :IngredientBuilder do
    attr_reader :ingredients

    def ingredient
      @ingredient ||= Ingredient.new
    end

    def ingredients_attributes=(attributes)
      @ingredients_attributes = Ingredient.new attributes
    end
  end

  concerning :RecipeIngredientBuilder do
    def recipe_ingredient
      @recipe_ingredient ||= RecipeIngredient.new
    end
  end

  def valid?
    valid_products = target_products.map(&:valid?).all?
    super && valid_products
  end

  def save
    return false unless valid?

    Product.transaction { target_products.each(&:save!) }
    true
  end

  def target_products
    products.select { |v| value_to_boolean(v.register) }
  end
end
