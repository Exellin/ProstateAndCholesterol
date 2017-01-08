require 'faker'

FactoryGirl.define do
  factory :cholesterol_history do
    association :profile, factory: :profile
    year { Faker::Date.between(120.years.ago, 18.years.ago).year }
    month { Faker::Date.between(120.years.ago, 18.years.ago).strftime('%B') }
    total_cholesterol { Faker::Number.between(100, 200) }
    hdl { Faker::Number.between(39, 150) }
    ldl { Faker::Number.between(0, 99) }
    triglyceride { Faker::Number.between(0, 149) }
    glucose { Faker::Number.between(70, 99) }
  end
end
