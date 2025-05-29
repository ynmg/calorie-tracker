class PortionsController < ApplicationController

  def destroy
    @portion = Portion.find(params[:id])
    @portion.destroy
    redirect_to meals_path
  end
end
