class Medication < ApplicationRecord
  belongs_to :profile
  validates :purpose, presence: true
  validates :name, presence: true
  validates :strength, presence: true
  validates :dosage, presence: true
  validates :year_last_used, :inclusion => { :in => 120.years.ago.year..0.years.ago.year, 
  :message => "must be between 0 and 120 years ago" }, :allow_blank => true
end
