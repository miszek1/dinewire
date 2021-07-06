class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
	
	def sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation,:first_name, :last_name, :user_name])
	end

end
