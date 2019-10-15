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

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(post_params)
    if @ingredient.save
      respond_with @ingredient, location: -> { ingredients_path }
    else
      render :new
    end
  end

  def edit
    @ingredient ||= Ingredient.find(params[:id])
  end

  def destroy
    @ingredient ||= Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def post_params
    params.require(:ingredient).permit(:name, :price, :unit)
  end
end
