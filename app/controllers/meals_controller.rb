class MealsController < ApplicationController
  def index
    @meals = current_user.meals
  end

  def new
    @meal = Meal.new
    3.times do
      @meal.portions.build
    end
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
    params.require(:meal).permit(:name, :date, portions_attributes:[:quantity, :ingredient_id])
  end

end
