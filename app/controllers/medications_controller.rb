class MedicationsController < ApplicationController
  include UserAccess
  before_action :authenticate_user!
  before_action :set_profile
  before_action {require_same_user(@profile)}
  
  def index
    if @profile.medications.nil?
      @profile.medications.build
    end
      @medications = @profile.medications
  end
  
  private
  
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
      