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

  def update
    @current_user.update(identity: params[:identity])
    if @current_user.valid? && @current_user.save
      return render status: 200
    else
      return render json: {errors: @current_user.errors}, status: 500
    end
  end

  def current
    render json: @current_user.attributes.except("password_digest")
  end

  def requests
  end

  def show
    @user = User.find_by_id(params[:id])

    if @user
      return render json: @user.attributes.except("password_digest")
    else
      return render status: 404
    end
  end

end
