require 'faker'

FactoryGirl.define do
  factory :psa_history do
    association :profile, factory: :profile
    year { Faker::Date.between(120.years.ago, 18.years.ago).year }
    month { Faker::Date.between(120.years.ago, 18.years.ago).month }
    psa { Faker::Number.decimal(1) }
  end
end
