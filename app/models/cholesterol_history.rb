class CholesterolHistory < ApplicationRecord
  belongs_to :profile
  validates :year, presence: true, inclusion: { in: 120.years.ago.year..0.years.ago.year, 
  message: 'must be between 0 and 120 years ago' }
  validates :month, presence: true
  validates :total_cholesterol, presence: true
  validates :hdl, presence: true
  validates :ldl, presence: true
  validates :triglyceride, presence: true
end
