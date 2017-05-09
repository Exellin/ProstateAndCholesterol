class CountryStateController < ApplicationController
  
  def find_administrative_divisions
    administrative_divisions = CS.states(params[:id]).sort_by { |a| a[1] }
    respond_to do |format|
      format.json { render :json => administrative_divisions.to_a }
    end
  end
  
  def find_cities
    cities_array = [];
    cities = CS.cities(params[:id])
    cities.each do |city|
      cities_array.push([city, city])
    end
    respond_to do |format|
      format.json { render :json => cities_array }
    end
  end
end