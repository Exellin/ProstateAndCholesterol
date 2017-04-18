require 'faker'

FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    content { Faker::Lorem.paragraph }
  end

  factory :child_comment, parent: :comment do
    association :parent_comment, factory: :comment
  end
end