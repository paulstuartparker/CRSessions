class SessionsController < ApplicationController
  def index
    @today_sessions = Session.happening_today.includes(:location)
    @upcoming_sessions = Session.upcoming.includes(:location)
  end

  def show
    @session = Session.find(params[:id])
  end

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    if @session.save
      redirect_to @session, notice: 'Session was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(
      :title, 
      :style, 
      :notes, 
      :start_time, 
      :end_time, 
      :recurrence_rule,
      :location_id
    )
  end
end 