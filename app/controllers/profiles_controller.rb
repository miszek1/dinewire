class ProfilesController < ApplicationController
 
  def show
    @user = User.find_by(user_name: params[:slug])
  end

end
