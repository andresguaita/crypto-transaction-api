class AuthController < ApplicationController

  # POST /login
  def login
    result = AuthenticationService.new(params[:email], params[:password]).authenticate

    if result[:error]
      render json: { error: result[:error] }, status: :unauthorized
    else
      render json: result, status: :ok
    end
  end

  # POST /register
  def register
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user}, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
