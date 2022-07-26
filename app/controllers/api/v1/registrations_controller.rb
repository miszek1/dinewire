class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_by_token, only: [:cancel]
  respond_to :json
	def cancel
		@current_user.messages.destroy_all
		@current_user.destroy
		render json: {message:"Account Removed"}, status: 200
	end
	def sign_up_params
		params.require(:user).permit(:email, :password, :password_confirmation,:first_name, :last_name, :user_name)
	end
end
