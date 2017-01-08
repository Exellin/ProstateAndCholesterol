require 'faker'

FactoryGirl.define do
  factory :profile do
    association :user, factory: :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth_year { Faker::Date.between(120.years.ago, 18.years.ago).year }
    city { Faker::Address.city }
    administrative_division { Faker::Address.state }
    country { Faker::Address.country }
    years_in_current_locale { Faker::Number.between(0, 120) }
    ancestral_descent { Faker::Lorem.word }
    race { Faker::Lorem.word }
    ethnicity { Faker::Lorem.word }
    story { Faker::Lorem.paragraph }
    age_noticed_symptoms { Faker::Number.between(0, 120) }
    age_urinary_malfunction { Faker::Number.between(0, 120) }
    age_bladder_infection { Faker::Number.between(0, 120) }
  end
  
  factory :anonymous_profile, parent: :profile do
    anonymous true
  end
end