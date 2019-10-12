# frozen_string_literal: true

# controller for Ingredients
class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = IngredientDecorator.decorate(Ingredient.page(params[:page]))
  end

  def show
    @ingredient = IngredientDecorator.decorate(Ingredient.find(params[:id]))
  end

  def new;
  end

  def edit;
  end

  def destroy
    @ingredient ||= Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end
end
