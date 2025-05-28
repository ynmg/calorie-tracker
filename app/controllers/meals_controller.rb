class MealsController < ApplicationController
  def index
    @todays_meals = current_user.meals.where(date: "2025-05-28")

    @calorie_breakdown = @todays_meals.includes(:portions => :ingredient).map do |meal|
    {
      meal_name: meal.name,
      calories: meal.portions.sum { |portion| portion.ingredient.calories * portion.quantity }
    }
    end
    @total_calories = @calorie_breakdown.sum { |m| m[:calories] }

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
