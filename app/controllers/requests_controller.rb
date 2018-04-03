class RequestsController < ApplicationController
  def index
    #@requests = Request.near([params[:lat], params[:lng]], params[:distance]).where(status: :unfulfilled)
    #@requests = Request.within_bounding_box(params[:box]).where(status: :unfulfilled)

    #return render json: @requests
  end

  def within
    box = params[:params][:box]

    bounds = [box[:sw][:lat], box[:sw][:lng], box[:ne][:lat], box[:ne][:lng]]
    @requests = Request.within_bounding_box(bounds).where(status: :unfulfilled)

    return render json: @requests
  end

  def show
    @request = Request.find_by_id(params[:id])

    if @request
      return render json: {request:@request}
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
      return render json: {id: @request.id}
    else
      return render status: 400
    end
  end

  def update

  end
end
