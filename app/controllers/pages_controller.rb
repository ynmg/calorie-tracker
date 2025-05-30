class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end
  def account
    @meals = current_user.meals.where(date: Date.today)
  end
end
