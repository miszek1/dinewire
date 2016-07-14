class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
	
	def sign_up_params
		params.require(:user).permit(:email, :password, :password_confirmation,:first_name, :last_name, :user_name)
	end

end
