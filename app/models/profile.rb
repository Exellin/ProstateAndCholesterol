class Profile < ApplicationRecord
  belongs_to :user
  has_many :psa_histories, dependent: :destroy
  has_many :cholesterol_histories, dependent: :destroy
  has_many :medications, dependent: :destroy
  
  validates :first_name, presence: :true, on: :update
  validates :last_name, presence: :true, on: :update
  validates :birth_year, presence: :true, on: :update
  validates :city, presence: :true, on: :update
  validates :administrative_division, presence: :true, on: :update
  validates :country, presence: :true, on: :update
  validates :years_in_current_locale, presence: :true, on: :update
  
  def empty?
    ignored_attrs = {'id' => 1 , 'user_id' => 1, 'created_at' => 1, 'updated_at' => 1}
    self.attributes.all?{|key, value| value.blank? || ignored_attrs[key]}
  end
  
  def country_name
    country_hash = ISO3166::Country[country]
    country_hash.translations[I18n.locale.to_s] || country_hash.name
  end
end
