class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    @user = User.new(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name])

    if @user.valid? && @user.save
      token =  AuthenticateUser.call(params[:email], params[:password])
      return render json: {token: token.result}
    else
      return render json: {error: 'Invalid params'}, status: :unauthorized
    end
  end

  def current
    render json: @current_user.attributes.except("password_digest")
  end
end
