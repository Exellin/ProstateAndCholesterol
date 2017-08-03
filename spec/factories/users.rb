require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Lorem.characters(10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :admin, parent: :user do
    admin true
  end
end
