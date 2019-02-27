require 'test_helper'
require "faker"
class UserControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  FactoryBot.define do
  	factory :validuser do
  		name {Faker::Name.name}
  		email {Faker::Internet.email}
      #password {Faker::Internet.password(min_length=8,max_length=16,mix_case=true,special_chars=false)}
  	
    #without email
    factory :invaliduser do
      name {Faker::Name.name}
      #password {Faker::Internet.password(6)}
    end
  end
  def setup
  	@validuser=create(:validuser)
    @invaliduser=create(:invaliduser)
  	@params={name:@user.name,email:@user.email}
    @headers={"Content-Type":"application/json","Accept":"application/json"}
  end
  test "get users" do    
  	get api_v1_user_index
  	assert_response 200, "response status should be 200"
  end
  test "create valid user" do
    skip
    assert_difference -> {User.count}  do
  	 #post '/api/v1/users', params: {user:{name:@validuser.name,email:@validuser.email,password:@validuser.password}}, as: :json #headers: {"Accept":"Application/json","Content-Type":"Application/json"}
    end
  	assert_response :success
  end 
  test "should not create an invaliduser user" do
    skip
    assert_no_difference -> {User.count} do
      #post '/api/v1/users', params: {user:{name:@invaliduser.name,password:@invaliduser.password}}
    end
    assert_response 400, "response should be Bad Request 400"
  end
end