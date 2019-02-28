# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

5.times do
	@user=User.create(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		username: Faker::Internet.username,
		password: Faker::Internet.password(min_length=8,max_length=8, mix_case=true, special_chars=false)
	)
end

	5.times do

		@blog=Blog.create(
			name: Faker::Name.name,
			user_id: @user.id
			)
	end
	5.times do
		@article=Article.create(
			title: Faker::Name.name,
			body: Faker::Lorem.sentence,
			user_id: @user.id,
			blog_id: @blog.id
			)
	end
	5.times do
		@comment=Comment.create(			
			body: Faker::Lorem.sentence,
			user_id: @user.id,
			article_id: @article.id
			)
	end
