class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
def home_page
  @skip_navbar = true
end

def authenticate_by_token
  if request.headers["authentication"]
    @current_user = User.find_by(authentication_token: request.headers["authentication"])
    if @current_user.nil?
      render json: {status: "500", error: "authentication failed"}
    end
  else 
    render json: {status: "500", error: "missing authentication"}
  end
end
end
