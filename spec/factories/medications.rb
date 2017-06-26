require 'faker'

FactoryGirl.define do
  factory :medication do
    association :profile, factory: :profile
    purpose { ["Prostate", "Cholesterol", "Blood Pressure"].sample }
    age_recommended { Faker::Number.between(18, 120) }
    age_prescribed { Faker::Number.between(18, 120) }
    name { Faker::Lorem.word }
    strength { Faker::Number.between(1, 2000) }
    dosage { Faker::Number.between(1, 10) }
    year_last_used { Faker::Date.between(120.years.ago, 18.years.ago).year }
    month_last_used { Faker::Date.between(120.years.ago, 18.years.ago).strftime('%B') }
    still_using { [true, false].sample }
  end
end
