class UsersController < ApplicationController

	before_action :authenticate_user, except: [:create]

	def index
		@users = User.all

		render json: @users
	end

	def create
		@user = User.new(user_params)

		if @user.save
			token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
			render json: { username: @user.username, email: @user.email }, status: :created
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.permit(:username, :email, :password, :password_confirmation)
	end
end