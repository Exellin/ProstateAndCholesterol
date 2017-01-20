class Medication < ApplicationRecord
  belongs_to :profile
  validates :purpose, presence: :true
  validates :name, presence: :true
  validates :strength, presence: :true
  validates :dosage, presence: :true
end
