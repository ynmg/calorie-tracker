class MealsController < ApplicationController
  def index
    @meals = current_user.meals
  end

  def new
    @meal = Meal.new
  end

  def create

  end
end
