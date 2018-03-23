class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.new(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name])

    if @user.valid? && @user.save
      return render json: @user
    else
      return render json: {error: 'Invalid params'}, status: :unauthorized
    end
  end
end
