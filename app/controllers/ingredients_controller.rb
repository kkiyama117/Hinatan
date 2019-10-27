# frozen_string_literal: true

# controller for Ingredients
class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = IngredientDecorator.decorate(Ingredient.page(params[:page]))
    authorize @ingredients
  end

  def show
    @ingredient = IngredientDecorator.decorate(Ingredient.find(params[:id]))
    authorize @ingredient
  end

  def new
    @ingredient = Ingredient.new
    authorize @ingredient
  end

  def create
    @ingredient = Ingredient.new(post_params)
    authorize @ingredient
    if @ingredient.save
      respond_with @ingredient, location: -> { ingredients_path }
    else
      render :new
    end
  end

  def edit
    @ingredient ||= Ingredient.find(params[:id])
    authorize @ingredient
  end

  def update
    @ingredient ||= Ingredient.find(params[:id])
    authorize @ingredient
    if @ingredient.update(post_params)
      respond_with @ingredient, location: -> { ingredients_path }
    else
      render :new
    end
  end

  def destroy
    @ingredient ||= Ingredient.find(params[:id])
    authorize @ingredient
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def post_params
    params.require(:ingredient).permit(:name, :price, :unit)
  end
end
