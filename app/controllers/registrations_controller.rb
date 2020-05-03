class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    create_vehicle_path
  end

end