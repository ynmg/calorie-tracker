class PortionsController < ApplicationController
  def new
    @meal = Meal.find(params[:meal_id])
    @portion = Portion.new
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @portion = Portion.new(portion_params)
    @portion.meal = @meal
    if @portion.save
      redirect_to new_meal_portion_path(@meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def portion_params
    params.require(:portion).permit(:quantity, :ingredient_id)
  end
end
