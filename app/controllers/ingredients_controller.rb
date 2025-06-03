class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end


  def create
    puts params

    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save!
      render json: Ingredient.all
    else
      render body: "error"
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories)
  end
end
