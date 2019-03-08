# frozen_string_literal: true

FactoryBot.define do
  factory :blog do
  	trait :validblog do
    	name { Faker::Name.name }
    	user_id { User.first.id || association(:user) }
    end
    trait :invalidblog do
    	name { Faker::Name.name }
    end
  end
end
