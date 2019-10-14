# frozen_string_literal: true

# app/models/form/product_collection.rb
class Form::RecipeForm < Form::Base
  concerning :RecipeBuilder do
    attr_accessor :recipes

    def initialize(attributes = {})
      super attributes
      self.recipe = recipe
      self.ingredients = ingredients
    end

    def recipe
      @recipe ||= Recipe.new
    end
  end

  concerning :IngredientBuilder do
    attr_reader :ingredients

    def ingredients
      @ingredients ||= Ingredient.new
    end

    def ingredients_attributes=(attributes)
      @ingredients_attributes = Ingredient.new attributes
    end
  end


  def products_attributes=(attributes)
    self.products = attributes.map do |_, product_attributes|
      Form::Product.new(product_attributes).tap { |v| v.availability = false }
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
