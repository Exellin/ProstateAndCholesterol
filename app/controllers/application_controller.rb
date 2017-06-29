class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private

  def after_sign_in_path_for(resource)
    if resource.profile.empty?
      redirect_path = root_path
    else
      redirect_path = profile_path(resource.profile)
    end
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_registration_path, alert: "You must sign in or sign up to view this page"
    end
  end
end
