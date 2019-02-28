FactoryBot.define do
  	factory :user do
      trait :validuser do
    		name {Faker::Name.name}
        username {Faker::Internet.username}
    		email {Faker::Internet.email}
        password {Faker::Internet.password(min_length=8,max_length=16,mix_case=true,special_chars=false)}
      end
      trait :invaliduser do
        name {Faker::Name.name}
        username {Faker::Internet.username}
        password {Faker::Internet.password(6)}  
      end
  	end
end