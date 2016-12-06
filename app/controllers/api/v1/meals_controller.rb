class Api::V1::MealsController < ApplicationController
  before_action :authenticate_by_token

  respond_to :json

  def index
    limit = params[:limit] || 10
    if params[:my_meals]
      meals = Meal.personal_meals(@current_user)
    else
      meals = Meal.public_meals(@current_user)
    end
    render json: meals, status: 200
  end

  def show
    meal = Meal.find(params[:id])
    if meal
      render json: meal, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end   

  def flag
    meal = Meal.find(params[:meal_id])
    if meal
      meal.flag!
      render json: meal, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end   

  def create        
    json = params.permit(:name, :description, :latitude, :longitude, :image)
    meal = @current_user.meals.build(json)
    meal.expires_at = DateTime.now + 1.hour

    if meal.save
      render json: meal, status: 200
    else
      render json: {status: "500", error: "record could not be created at this time"}, status: 500
    end
  end

  def destroy
   meal = Meal.find(params[:id])
   if meal
    meal.delete
    render json: {status: "200", message: "record successfully deleted"}, status: 200
  else 
    render json: {status: "404", error: "record not found"}, status: 404
  end
  end

  def update
    meal = Meal.find(params[:id])
    json = params.permit(:name, :description, :latitude, :longitude, :image)
    if meal
      meal.update(json)
      render json: meal, status: 200
    else
      render json: {status: "404", error: "record not found"}, status: 404
  end
end
end

