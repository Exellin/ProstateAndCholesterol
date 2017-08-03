require 'faker'

FactoryGirl.define do
  factory :post do
    association :user, factory: :user
    association :topic, factory: :topic
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
