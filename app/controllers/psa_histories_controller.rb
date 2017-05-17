class PsaHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :require_same_user
    
  def index
    if @profile.psa_histories.nil?
      @profile.psa_histories.build
    end
    @psa_histories = @profile.psa_histories
  end
  
  private
  
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
  
  def require_same_user
    if current_user != @profile.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own profile"
      redirect_to root_path
    end
  end
end