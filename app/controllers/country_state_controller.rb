class CountryStateController < ApplicationController
  
  def find_administrative_divisions
    administrative_divisions = CS.states(params[:id])
    respond_to do |format|
      format.json { render :json => administrative_divisions.to_a }
    end
  end
  
  def find_cities
    cities = CS.cities(params[:id])
    respond_to do |format|
      format.json { render :json => cities.to_a }
    end
  end
end