class CholesterolHistoriesController < ApplicationController
  include UserAccess
  include ProfileAccess
  before_action :authenticate_user!
  before_action :set_profile
  before_action {require_same_user(@profile)}
  before_action :require_filled_profile
  
  def index
    if @profile.cholesterol_histories.nil?
      @profile.cholesterol_histories.build
    end
    @cholesterol_histories = @profile.cholesterol_histories
  end
  
  private
  
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end