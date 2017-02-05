class PsaHistory < ApplicationRecord
  belongs_to :profile
  validates :year, presence: true, :inclusion => { :in => 120.years.ago.year..0.years.ago.year, 
  :message => "must be between 0 and 120 years ago" }
  validates :month, presence: true
  validates :psa, presence: true, :inclusion => { :in => 0..999.9, :message => "must be between 0 and 999.9" }
end
