# frozen_string_literal: true

FactoryBot.define do
  factory :blog do
    name { Faker::Name.name }
    user_id { User.first.id || association(:user) }
  end
end
