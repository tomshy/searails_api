FactoryBot.define do
  		factory :article do
  			title {Faker::Name.name}
  			body	{Faker::Lorem.sentence}
        blog_id {Blog.first.id || association(:blog)}
        user_id {User.first.id || association(:user)}
  		end
  	end