class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
      render json: { token: token }
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end
end
