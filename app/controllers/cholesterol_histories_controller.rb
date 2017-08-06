class CholesterolHistoriesController < ApplicationController
  include UserAccess
  include ProfileAccess
  before_action :authenticate_user!
  before_action :set_profile
  before_action { require_same_user(@profile) }
  before_action :require_filled_profile

  def index; end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
