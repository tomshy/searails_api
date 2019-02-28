require 'test_helper'
require "faker"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions
  def setup
  	@validuser=build(:user, :validuser) 
    @invaliduser=build(:user, :invaliduser)  	    
  end
  test "get users" do    
    #skip
  	get api_v1_users_path
  	assert_response 200, "response status should be 200"
  end
  test "create valid user" do
    #skip
    assert_difference -> {User.count}  do
  	 create(:user, :validuser)
    end
  end 
  test "should not create an invalid user" do
    #skip
    assert_no_difference -> {User.count} do
      post api_v1_users_path, params: {user:{name:@invaliduser.name,password:@invaliduser.password}}  
    end
    assert @invaliduser.valid?, @invaliduser.errors.full_messages.inspect
    assert_response 400, "response should be Bad Request 400"
  end
end