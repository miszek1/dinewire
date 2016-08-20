class Api::V1::SearchesController < ApplicationController
  before_action :authenticate_by_token
  def show
    search = Meal.search(params[:q]).near(request.location.coordinates, 20, :order => "distance")
    if search
      render json: search, status: 200
    else
      render json: {status: "404", error: "No records found"}, status: 404
    end
  end
end
