class RequestsController < ApplicationController
  def index
    @requests = Request.where(status: :unfulfilled)
  end

  def create
    @request = Request.new(address: params[:address], title: params[:title], description: params[:description], lat: params[:lat], lng: params[:lng], reqtype: params[:reqtype])
    @request.user_id = @current_user.id

    if @request.valid? && @request.save
      return render status: 200
    else
      return render status: 400
    end
  end

  def update

  end
end
