class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @meals = Meal.ready_to_eat
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
