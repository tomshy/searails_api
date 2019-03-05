FactoryBot.define do
  		factory :comment do
  			body  {Faker::Lorem.sentence}
  			user_id {User.last.id || association(:user)}
  			article_id {Article.last.id || association(:article)}        
  		end
  	end