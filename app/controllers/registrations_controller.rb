class RegistrationsController < Devise::RegistrationsController
  # def new
  #   render status: 200
  # end

  protected

  def after_sign_up_path_for(resource)
    create_vehicle_path
  end

end