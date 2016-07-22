class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
   json = params[:body]
   pw = json["password"]
   email = json["email"]
   user = User.find_by(email: email.downcase)
   if user && user.valid_password?(pw)
    render json: {success: true, user: {authentication_token: user.authentication_token}}
  else 
    render json: {status: "403",success: false, error: "Oops, your password or email is incorrect"}
   end
  end
end