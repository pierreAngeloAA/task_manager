class Api::UsersController < ApplicationController
  include Authenticable

  def index
    render json: User.all
  end

  def me
    render json: @current_user, include: :tasks
  end
end
