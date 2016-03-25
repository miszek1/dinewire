class Api::V1::MealsController < ApplicationController
  respond_to :json

  def index
    limit = params[:limit] || 10
    meals = Meal.all.limit(limit)
    render json: meals
  end

  def show
    meal = Meal.find(params[:id])
    render json: meal
  end
end

