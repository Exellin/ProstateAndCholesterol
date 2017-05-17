class CholesterolHistoriesController < ApplicationController
  include UserAccess
  before_action :authenticate_user!
  before_action :set_profile
  before_action {require_same_user(@profile)}
  
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