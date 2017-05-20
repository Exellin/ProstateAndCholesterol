class PsaHistoriesController < ApplicationController
  include UserAccess
  include ProfileAccess
  before_action :authenticate_user!
  before_action :set_profile
  before_action {require_same_user(@profile)}
  before_action :require_filled_profile
    
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
end