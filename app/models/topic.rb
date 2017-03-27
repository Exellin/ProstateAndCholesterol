class Topic < ApplicationRecord
  has_many :posts
  
  validates :name, presence: true
  validates_uniqueness_of :name
end