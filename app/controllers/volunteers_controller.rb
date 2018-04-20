class VolunteersController < ApplicationController
  before_action :volunteer_id_needed, only: [:update, :destroy]
  before_action :request_id_needed, only: [:index, :create, :update]

  def index
    @request = Request.includes(:volunteers, :messages, :user).find_by_id(params[:request_id])

    if @request.user_id != @current_user.id
      return render status: 403
    end

    return render json: @request, :include => {
        :volunteers => {
            :only => [:id, :user_id, :status],
            :include => {
                :messages => {
                :include => {
                    :user => {
                        :only => [:id, :first_name, :last_name, :email]
                    }
                }
            },
                :user => {
                    :only => [:id, :first_name, :last_name]
                }
            }
        },
    }
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
    @request = Request.find_by_id(params[:request_id])
    @volunteer = Volunteer.find_by_id(params[:id])

    if @request.user_id == @current_user.id || @volunteer.user_id == @current_user.id
      if(params[:type] && params[:type] == 'decline')
        @volunteer.status = 'declined'
        if @volunteer.save
          return render status: 200
        else
          return render status: 400
        end
      end
      @request.status = 'fulfilled'
      @volunteer.status = 'accepted'

      if @request.save && @volunteer.save
        @otherVolunteers = Volunteer.where(request_id: params[:request_id]).where.not(id: params[:id])
        @otherVolunteers.each do |vol|
          vol.status = 'declined'
          vol.save
        end
        return render status: 200
      else
        return render status: 400
      end
    else
      return render status: 403
    end
  end

  def destroy
    @volunteer = Volunteer.where('volunteers.request_id = ? AND volunteers.user_id = ?', params[:id], @current_user.id)

    return render status: 404 unless @volunteer

    @volunteer.destroy_all
    return render status: 200

  end

  def proposals
    @proposals = Request.joins(:volunteers).where('volunteers.user_id = ?', @current_user.id)

    if @proposals
      return render json: @proposals, :include => [:volunteers]
    else
      return render 404
    end
  end

  private

  def volunteer_id_needed
    return render status: 400 unless params[:id]
  end

  def request_id_needed
    return render status: 400 unless params[:request_id]
  end
end
