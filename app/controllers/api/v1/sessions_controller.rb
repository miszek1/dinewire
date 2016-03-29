class SessionsController < ApplicationController
  respond_to :json

  def create
   json = JSON.parse(params[:body])
    
  end
end
