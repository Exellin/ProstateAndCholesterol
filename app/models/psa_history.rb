class PsaHistory < ApplicationRecord
  belongs_to :profile
  validates :year, presence: true
  validates :month, presence: true
  validates :psa, presence: true
end
