module Authentication

	def authenticate_user
		token = request.headers['Authorization'].split(' ')[1]
		begin
			decoded_token = JWT.decode(token, Rails.application.secrets_key_base, true, algorithm: 'HS256')
			@user_id = decoded_token.first['user_id']
			@current_user = User.find(@user_id)
		rescue JWT::DecodeError
			render json: { errors: ' Invalid token'}, status: :unauthorized
		end
	end
end
