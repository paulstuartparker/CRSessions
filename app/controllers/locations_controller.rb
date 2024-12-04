class LocationsController < ApplicationController
  def new
    @location = Location.new
    render layout: !turbo_frame_request?
  end

  def create
    @location = Location.new(location_params)
    
    if @location.save
      if turbo_frame_request?
        render partial: "sessions/location_select", 
               locals: { f: SimpleForm::FormBuilder.new("session", Session.new, self, {}) }
      else
        redirect_to locations_path, notice: "Location created successfully"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:location).permit(
      :name,
      :address,
      :city,
      :state,
      :zip_code,
      :additional_details
    )
  end
end 