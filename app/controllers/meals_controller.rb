class MealsController < ApplicationController
  def index
    @meals = current_user.meals
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    if @meal.save
      redirect_to meals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :date)
  end

end
