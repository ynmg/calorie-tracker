class MealsController < ApplicationController
  def index
    @todays_meals = current_user.meals.where(date: Date.today)
    # should change to Date.today when everything is set

    @calorie_breakdown = @todays_meals.includes(:portions => :ingredient).map do |meal|
    {
      id: meal.id,
      meal_name: meal.name,
      calories: meal.portions.sum { |portion| portion.ingredient.calories * portion.quantity }
    }
    end
  @total_calories = @calorie_breakdown.sum { |m| m[:calories] }
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
    1.times do
      @meal.portions.build
    end
    @ingredients = Ingredient.all
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    if @meal.save
      # redirect_to meals_path
      redirect_to new_meal_portion_path(@meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :date, portions_attributes:[:quantity, :ingredient_id])
  end
end
