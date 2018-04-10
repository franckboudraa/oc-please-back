class ApplicationController < ActionController::API
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:stats]
  attr_reader :current_user

  def stats
    @user_count = User.count
    @requests_fulfilled = Request.where(status: :fulfilled).count()
    @requests_unfulfilled = Request.where(status: :unfulfilled).count()

    if @user_count
      return render json: {user_count: @user_count, requests_fulfilled: @requests_fulfilled, requests_unfulfilled: @requests_unfulfilled}
    else
      return render status: 503
    end
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
