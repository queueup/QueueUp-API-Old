class UserController < ApplicationController
  before_action :authenticate_user!, only: [:update_password, :validate_token]

  def sign_up
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password])
    if user.save
      user.access_token = user.sign_in
      render json: user, serializer: SignInSerializer
    else
      render json: user.errors, status: :bad_request
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      user.access_token = user.sign_in
      render json: user, serializer: SignInSerializer
    else
      render body: nil, status: :bad_request
    end
  end

  def validate_token
  end

  def update_password
    if @current_user.valid_password?(params[:current_password])
      if @current_user.update(password: params[:new_password])
        render json: @current_user
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    else
      render body: nil, status: :bad_request
    end
  end
end
