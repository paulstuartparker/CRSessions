class CreativeSessionsController < ApplicationController
  before_action :set_creative_session, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @today_sessions = CreativeSession.happening_today.includes(:location)
    @upcoming_sessions = CreativeSession.upcoming.includes(:location)
  end

  def show
  end

  def new
    @creative_session = CreativeSession.new
  end

  def create
    @creative_session = CreativeSession.new(creative_session_params)
    assign_location_to_session

    if @creative_session.save
      redirect_to creative_sessions_path, notice: "Session was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    assign_location_to_session

    if @creative_session.update(creative_session_params)
      redirect_to creative_sessions_path, notice: "Session was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @creative_session.destroy
    redirect_to creative_sessions_path, notice: "Session was successfully deleted."
  end

  private

  def set_creative_session
    @creative_session = CreativeSession.find(params[:id])
  end

  def creative_session_params
    params.require(:creative_session).permit(
      :title,
      :style,
      :start_time,
      :end_time,
      :location_id,
      :notes,
      :recurring,
      :recurrence_rule
    )
  end

  def authorize_user!
    return if current_user.admin?
    if current_user.location_user?
      unless @creative_session.location_id == current_user.location_id
        redirect_to creative_sessions_path, alert: "You are not authorized to perform this action."
      end
    else
      redirect_to creative_sessions_path, alert: "You are not authorized to perform this action."
    end
  end

  def assign_location_to_session
    if current_user.location_user?
      @creative_session.location_id = current_user.location_id
    end
  end
end
