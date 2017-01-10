require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
  
  factory :admin, parent: :user do
    admin true
  end
end
