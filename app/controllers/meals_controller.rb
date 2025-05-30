class MealsController < ApplicationController
  def index
    @meals = current_user.meals.where(date: Date.today)

    @breakfasts = @meals.where(name: "Breakfast")
    @lunches = @meals.where(name: "Lunch")
    @dinners = @meals.where(name: "Dinner")
    @snacks = @meals.where(name: "Snack")
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
