require 'test_helper'
require 'faker'
class BlogControllerTest < ActionDispatch::IntegrationTest
	include FactoryBot::Syntax::Methods
  	FactoryBot.define do
  		factory :blog do
  			name {Faker::Name.name}
  			user_id {User.first.id || association(:user)}
  		end
  	end
  	def setup
  		@blog=create(:blog)
      @auth_headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}","Accept"=>"application/vnd.api+json"}
  	end
  	test "create new blog by registered user" do
  		#skip
  		assert_difference -> {Blog.count} do
  			create(:blog)        
  		end  		
  	end
  	test "retrieve all blogs" do
  		#skip
  		get api_v1_user_blogs_path(user_id:@blog.user_id)
  		assert_response 200
  	end  	
  	test "delete a blog by id" do
  		#skip
  		assert_difference -> {Blog.count}, -1 do
  			delete api_v1_user_blog_path(user_id:@blog.user_id,id:@blog.id), as: :json, headers: @auth_headers
  		end
  		assert_response :success
  	end
end
