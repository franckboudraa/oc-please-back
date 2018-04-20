class MessagesController < ApplicationController
  before_action :volunteer_id_needed, only: [:create]

  def create
    @volunteer = Volunteer.find_by_id(params[:id])
    if @volunteer && @volunteer.user_id == @current_user.id || @volunteer && @volunteer.request.user_id == @current_user.id
        @message = Message.new(user_id: @current_user.id, content: params[:content], volunteer_id: @volunteer.id)
        if @message.valid? && @message.save
          return render json:{request_id: @volunteer.request.id}, status: 201
        else
          return render status: 400
        end
    else
      return render status: 404
    end
  end

  private
  def volunteer_id_needed
    return render status: 400 unless params[:id]
  end
end
