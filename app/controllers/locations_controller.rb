class LocationsController < ApplicationController
  def new
    @location = Location.new
    
    if turbo_frame_request?
      render partial: "form", locals: { location: @location }
    else
      render :new
    end
  end

  def create
    @location = Location.new(location_params)
    
    if @location.save
      if turbo_frame_request?
        render partial: "sessions/location_select", 
               locals: { f: SimpleForm::FormBuilder.new("session", 
                                                       Session.new, 
                                                       view_context, 
                                                       {}) }
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
      :latitude,
      :longitude,
      :additional_details
    )
  end
end 