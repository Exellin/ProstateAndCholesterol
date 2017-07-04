require 'faker'

FactoryGirl.define do
  factory :topic do
    name {Faker::Lorem.unique.word }
  end
end