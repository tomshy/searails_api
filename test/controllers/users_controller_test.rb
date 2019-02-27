require 'test_helper'
require "faker"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  FactoryBot.define do
  	factory :validuser, class: User do
  		name {Faker::Name.name}
      username {Faker::Internet.username}
  		email {Faker::Internet.email}
      password {Faker::Internet.password(min_length=8,max_length=16,mix_case=true,special_chars=false)}
  	end
    #without email and weaker password
    #binding.pry
    factory :invaliduser, class: User do
      name {Faker::Name.name}
      username {Faker::Internet.username}
      password {Faker::Internet.password(6)}
    end
  end
  def setup
  	@validuser=create(:validuser)
    @invaliduser=create(:invaliduser)  	    
  end
  test "get users" do    
    skip
  	get api_v1_users_path
  	assert_response 200, "response status should be 200"
  end
  test "create valid user" do
    skip
    assert_difference -> {User.count}  do
  	 post api_v1_users_path, params: {user:{name:@validuser.name,email:@validuser.email,password:@validuser.password}}, as: :json
    end
  	assert_response :success
  end 
  test "should not create an invalid user" do
    skip
    assert_no_difference -> {User.count} do
      post api_v1_users_path, params: {user:{name:@invaliduser.name,password:@invaliduser.password}}  
    end
    assert @invaliduser.valid?, @invaliduser.errors.full_messages.inspect
    assert_response 400, "response should be Bad Request 400"
  end
end