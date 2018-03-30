class RequestsController < ApplicationController
  def index
    @requests = Request.where(status: :unfulfilled)
  end

  def show
    @request = Request.find_by_id(params[:id])

    if @request
      return render json: {request:@request}, status:200
    else
      return render status: 404
    end
  end

  def create
    @request = Request.new(address: params[:address],
                           title: params[:title],
                           description: params[:description],
                           lat: params[:lat],
                           lng: params[:lng],
                           reqtype: params[:reqtype])

    @request.user_id = @current_user.id

    if @request.valid? && @request.save
      return render json: {id: @request.id}, status: 200
    else
      return render status: 400
    end
  end

  def update

  end
end
