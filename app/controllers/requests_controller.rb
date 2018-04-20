class RequestsController < ApplicationController
  skip_before_action :authenticate_request, only: [:show]

  def index
    if params[:user_id]
      @requests = Request.includes(:user, :volunteers).where(user_id: params[:user_id]).order('id DESC')
    else
      @requests = Request.all
    end

    return render json: @requests, :include => {:user => {:only => [:first_name, :last_name]}, :volunteers => {:only => [:id, :user_id, :created_at]}}
  end

  def within
    box = params[:params][:box]
    bounds = [box[:sw][:lat], box[:sw][:lng], box[:ne][:lat], box[:ne][:lng]]
    @requests = Request.includes(:user, :volunteers).where(status: :unfulfilled).within_bounding_box(bounds)
    return render json: @requests, :include => {:user => {:only => [:first_name, :last_name]}, :volunteers => {:only => [:id]}}, :except => [:status, :updated_at]
  end

  def show
    @request = Request.includes(:user, :volunteers).find_by_id(params[:id])

    if @request
      return render json: @request, :include => {
          :user => {
              :only => [:id, :first_name, :last_name, :email]},
          :volunteers => {
              :only => [:id, :status, :created_at],
              :include => {
                  :user => {
                      :only => [:id, :first_name, :last_name]
                  }
              }
          }
      }
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
                           reqtype: params[:reqtype],
                           user_id: @current_user.id)

    if @request.valid? && @request.save
      return render json: {id: @request.id}
    else
      return render status: 400
    end
  end

  def update

  end

  def destroy
    @request = Request.find_by_id(params[:id])

    return render status: 404 unless @request

    if @request.user_id == @current_user.id
      @request.destroy
      return render status: 200
    else
      return render status: 403
    end
  end
end
