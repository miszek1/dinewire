class SessionsController < ApplicationController
  responds_to :json

  def create
   json = JSON.parse(params[:body])
    
  end
end
