class CountryStateController < ApplicationController
  
  def find_administrative_divisions
    administrative_divisions = CS.states(params[:country_id])
    respond_to do |format|
      format.json { render :json => administrative_divisions.to_a }
    end
  end
end