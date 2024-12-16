   class RegistrationsController < Devise::RegistrationsController
     before_action :configure_permitted_parameters

     protected

     def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [location_attributes: [:name, :address, :city, :state, :zip_code, :latitude, :longitude, :additional_details]])
     end

     def build_resource(hash = {})
       super(hash)
       resource.build_location if resource.location.nil?
     end
   end