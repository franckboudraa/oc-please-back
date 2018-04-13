class VolunteersController < ApplicationController
  before_action :volunteer_id_needed, only: [:show, :update, :destroy]
  before_action :request_id_needed, only: [:create]

  def index
    return render status: 200
  end

  def create
    @request = Request.find_by_id(params[:request_id])
# add count to check 5 volunteers
    if @request && @request.unfulfilled?
      @volunteer = Volunteer.new(request_id: params[:request_id], user_id: @current_user.id, status: 0)

      if @volunteer.valid? && @volunteer.save
        @message = Message.new(user_id: @current_user.id, content: params[:message], volunteer_id: @volunteer.id)
        if @message.valid? && @message.save
          return render status: 201
        else
          @volunteer.destroy
          return render status: 400
        end
      else
        return render status: 400
      end
    else
      return render status: 404
    end
  end

  def update

  end

  def destroy

  end

  private

  def volunteer_id_needed
    return render status: 400 unless params[:id]
  end

  def request_id_needed
    return render status: 400 unless params[:request_id]
  end
end
