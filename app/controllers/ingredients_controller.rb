# frozen_string_literal: true

# controller for Ingredients
class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def show
    @ingredients = IngredientDecorator.decorate(Ingredient.all)
  end

  def new; end

  def edit; end
end
