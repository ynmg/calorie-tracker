class PortionsController < ApplicationController
  
  def destroy
    @portion = Portion.find(params[:id])
    @portion.destroy
    redirect_to meals_path
  end

  before_action :set_portion, only: [ :show, :update ]

  def show
  end

  def update
    if @portion.update(portion_param)
      redirect_to portion_path(@portion), notice: "Portion was successfully updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def portion_param
    params.require(:portion).permit(:quantity)
  end

  def set_portion
    @portion =  Portion.find(params[:id])
  end

end
