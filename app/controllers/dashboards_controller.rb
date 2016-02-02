class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @meals = Meal.public_meals(current_user)
    @personal_meals = Meal.personal_meals(current_user)

  end



 end