class MealsController < ApplicationController
  def index
    begin
      date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    rescue ArgumentError
      date = Date.today
    end

    @todays_meals = current_user.meals.where(date: date)

    @calorie_breakdown = []

    [ "Breakfast", "Lunch", "Dinner", "Snack" ].each do |meal_name|
      if meal_name == "Snack"
        meals = @todays_meals.where(name: meal_name)
      else
        meal = @todays_meals.find_by(name: meal_name)
        meals = meal.present? ? [ meal ] : []
      end

      total_calories = 0
      meals.each do |meal|
        meal.portions.includes(:ingredient).each do |portion|
          total_calories += portion.ingredient.calories * portion.quantity
        end
      end

      @calorie_breakdown << {
        meal_name: meal_name,
        calories: total_calories
      }
    end
    @total_calories = @calorie_breakdown.sum { |meal| meal[:calories] }
    @selected_date = date
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
      redirect_to meals_path
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
