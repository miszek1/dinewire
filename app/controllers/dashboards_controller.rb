class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @meals = Meal.public_meals(current_user)
    @personal_meals = Meal.personal_meals(current_user)
  end

  def home_page_redirecter
    if signed_in?
      redirect_to dashboard_path
    else
    redirect_to page_path("home")
  end
  end
end
