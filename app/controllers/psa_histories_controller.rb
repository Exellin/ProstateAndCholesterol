class PsaHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
    
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