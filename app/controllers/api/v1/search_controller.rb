class Api::V1::SearchController < ApplicationController
  before_action :authenticate_by_token

  respond_to :json

  def index
    searchMeals = Meal.search(params[:q]).near(request.location.coordinates, 20, :order => "distance")
    if searchMeals
      render json: searchMeals, status: 200
    else 
      render json: {status: "404", error: "record not found"}, status: 404
    end
  end   

end

