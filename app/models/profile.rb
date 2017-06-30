class Profile < ApplicationRecord
  belongs_to :user
  has_many :psa_histories, dependent: :destroy
  has_many :cholesterol_histories, dependent: :destroy
  has_many :medications, dependent: :destroy
  
  accepts_nested_attributes_for :psa_histories, :allow_destroy => true
  accepts_nested_attributes_for :cholesterol_histories, :allow_destroy => true
  accepts_nested_attributes_for :medications, :allow_destroy => true
  
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :birth_year, presence: true, on: :update, :inclusion => { :in => 120.years.ago.year..18.years.ago.year, 
  :message => "must be between 120 and 18 years ago" }
  validates :city, presence: true, on: :update
  validates :administrative_division, presence: true, on: :update
  validates :country, presence: true, on: :update
  validates :years_in_current_locale, presence: true, on: :update, :inclusion => { :in => 0..120, 
  :message => "must be between 0 and 120" }
  validates :race, presence: true, on: :update
  validates :age_noticed_symptoms, :inclusion => { :in => 18..120,
  :message => "must be between 18 and 120" }, :allow_blank => true
  validates :age_urinary_malfunction, :inclusion => { :in => 18..120,
  :message => "must be between 18 and 120" }, :allow_blank => true
  validates :age_bladder_infection, :inclusion => { :in => 18..120,
  :message => "must be between 18 and 120" }, :allow_blank => true
  
  def empty?
    ignored_attrs = {'id' => 1 , 'user_id' => 1, 'created_at' => 1, 'updated_at' => 1}
    self.attributes.all?{|key, value| value.blank? || ignored_attrs[key]}
  end
  
  def set_countries
    countries_array = CS.countries.to_a.sort_by { |a| a[1] }
    remove_index = countries_array.index(countries_array.detect{|country| country.include?('country_name')})
    countries_array.delete_at(remove_index)
    countries_array.collect {|country| [country[1], country[0]]}
  end
  
  def set_administrative_divisions
    if country
      administrative_divisions = CS.states(country.to_sym).sort_by { |a| a[1] }
      administrative_divisions.collect {|state| [state[1], state[0]]}
    else
      administrative_divisions = CS.states(:us).sort_by { |a| a[1] }
      administrative_divisions.collect {|state| [state[1], state[0]]}
    end
  end
  
  def set_cities
    if administrative_division
      CS.cities(administrative_division.to_sym).collect {|city| [city, city]}
    else
      CS.cities(:al).collect {|city| [city, city]}
    end
  end
  
  def country_name
    CS.countries[country.to_sym]
  end
  
  def state_name
    state_name = CS.states(country)[administrative_division.to_sym]
    if state_name.nil?
      administrative_division
    else
      state_name
    end
  end
end
