require 'faker'

FactoryGirl.define do
  factory :user do
    username "username"
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
  
  factory :admin, parent: :user do
    admin true
  end
end
