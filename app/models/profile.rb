class Profile < ApplicationRecord
  belongs_to :user
  has_many :psa_histories, inverse_of: :profile, dependent: :destroy
  has_many :cholesterol_histories, dependent: :destroy
  has_many :medications, dependent: :destroy
  
  accepts_nested_attributes_for :psa_histories, :allow_destroy => true
  accepts_nested_attributes_for :cholesterol_histories, :allow_destroy => true
  accepts_nested_attributes_for :medications, :allow_destroy => true
  
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :birth_year, presence: true, on: :update, :inclusion => { :in => 1900..18.years.ago.year, 
  :message => "must be between 1900 and 18 years ago" }
  validates :city, presence: true, on: :update
  validates :administrative_division, presence: true, on: :update
  validates :country, presence: true, on: :update
  validates :years_in_current_locale, presence: true, on: :update, :inclusion => { :in => 0..120, 
  :message => "must be between 0 and 120" }
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
  
  def country_name
    unless country.nil?
      country_hash = ISO3166::Country[country]
      country_hash.translations[I18n.locale.to_s] || country_hash.name
    end
  end
end
