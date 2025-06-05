class MealsController < ApplicationController

  def index
    if params[:date] != nil
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end
    @meals = current_user.meals.where(date: @date)
    @breakfasts = @meals.where(name: "Breakfast")
    @lunches = @meals.where(name: "Lunch")
    @dinners = @meals.where(name: "Dinner")
    @snacks = @meals.where(name: "Snack")
  end

  def trend
    # @meals = current_user.meals.where(date: Date.today)
    # return an array of all Meal objects with ingredients & poritons of user without looping extra enquiries within the past 7 days
    recent_meals = current_user.meals.includes(portions: :ingredient).where("created_at >= ?", 7.days.ago)

    # replace array of meals with the sum of their total_calories
    # line 16: return a hash with an array of Meal objects(values) and the created date(key)
    # line 17: calculate the sum of total calories of all meals in the array of that day
    raw_calories_by_day = recent_meals.group_by { |meal| meal.date.to_date.to_s }
      .transform_values { |meals| meals.sum { |meal| meal.total_calories } }

    # included days with 0 calories in the line graph
    @dates = (6.days.ago.to_date..Date.today).map { |date| date.to_s }
    @calories_by_day = @dates.map do |date|
      formatted_date = Date.parse(date).strftime("%d %b")
      calories = raw_calories_by_day[date] || 0    # included days with 0 calories in the line graph
      [ formatted_date, calories.round ]
    end.to_h
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

    if @meal.save!
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
