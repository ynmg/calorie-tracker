class PortionsController < ApplicationController

  before_action :set_portion, only: [ :show, :update ]
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

  def show
  end

  def update
    if @portion.update(portion_params)
      redirect_to portion_path(@portion), notice: "Portion was successfully updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @portion = Portion.find(params[:id])
    @meal = @portion.meal
    @portion.destroy
    redirect_to new_meal_portion_path(@meal), notice: "Portion was successfully deleted."
  end

  private

  def portion_params
    params.require(:portion).permit(:quantity, :ingredient_id)
  end

  def set_portion
    @portion =  Portion.find(params[:id])
  end

end
