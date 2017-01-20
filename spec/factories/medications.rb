require 'faker'

FactoryGirl.define do
  factory :medication do
    association :profile, factory: :profile
    purpose { Faker::Lorem.word }
    age_recommended { Faker::Date.between(120.years.ago, 18.years.ago).year }
    age_prescribed { Faker::Date.between(120.years.ago, 18.years.ago).year }
    name { Faker::Lorem.word }
    strength { Faker::Number.between(1, 2000) }
    dosage { Faker::Number.between(1, 10) }
    year_last_used { Faker::Date.between(120.years.ago, 18.years.ago).year }
    month_last_used { Faker::Date.between(120.years.ago, 18.years.ago).strftime('%B') }
  end
end
