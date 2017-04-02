class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_registration_path, alert: "You must sign in or sign up to view this page"
    end
  end
end
