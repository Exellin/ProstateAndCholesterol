class PsaHistory < ApplicationRecord
  belongs_to :profile
  validates :year, presence: true
  validates :month, presence: true
  validates :psa, presence: true, :inclusion => { :in => 0..999.9, :message => "must be between 0 and 999.9" }
end
