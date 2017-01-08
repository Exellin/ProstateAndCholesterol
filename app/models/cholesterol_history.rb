class CholesterolHistory < ApplicationRecord
  belongs_to :profile
  validates :year, presence: true
  validates :month, presence: true
  validates :total_cholesterol, presence: true
  validates :hdl, presence: true
  validates :ldl, presence: true
  validates :triglyceride, presence: true
end
