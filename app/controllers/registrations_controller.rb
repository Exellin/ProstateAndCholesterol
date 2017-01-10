class RegistrationsController < Devise::RegistrationsController
    
  protected
  
  def after_sign_up_path_for(resource)
    profile_path(resource.profile)
  end
  
  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
  
end