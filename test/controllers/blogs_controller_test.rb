require 'test_helper'
require 'faker'
class BlogControllerTest < ActionDispatch::IntegrationTest
	include FactoryBot::Syntax::Methods
  	FactoryBot.define do
  		factory :blog do
  			name {Faker::Name.name}
  			user_id {980190962}
  		end
  	end
  	def setup
  		@blog=create(:blog)
      @auth_headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}"}
  	end
  	test "create new blog by registered user" do
  		skip
  		assert_difference -> {Blog.count} do
  			post api_v1_blog_index_path, params: {blog:{name: @blog.name, user_id:980190962}}, as: :json, headers: @auth_headers
  		end
  		assert_response :success
  	end
  	test "retrieve all blogs" do
  		skip
  		get api_v1_blog_index_path
  		assert_response 200
  	end
  	#binding.pry
  	test "delete a blog by id" do
  		skip
  		assert_difference -> {Blog.count}, -1 do
  			delete api_v1_blog_path(id:@blog.id), as: :json, headers: @auth_headers
  		end
  		assert_response :success
  	end
end
