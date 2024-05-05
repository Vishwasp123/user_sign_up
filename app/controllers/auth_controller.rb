class AuthController < ApplicationController

	def create
	byebug 
		@user = User.find_by(email: params[:email])

		if @user&.authenticate(params[:password])
			token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
			render json: { token: token }
		else
			render json: { error: 'Invalid credentials'}, status: :unathorized
		end
	end
end
 