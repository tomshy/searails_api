require 'test_helper'
require "faker"

class UsersControllerTest < ActionDispatch::IntegrationTest  
  
  def setup
  	@validuser=build(:user, :validuser) 
    @invaliduser=build(:user, :invaliduser)  	    
  end
  test "get users" do    
    skip
  	get api_v1_users_path, as: :json
  	assert_response 200, "response status should be 200"
  end 
  test "should create a validuser user" do
    post api_v1_users_path, params: {user:
                                      {
                                        name:@validuser.name,
                                        password:@validuser.password,
                                        username:@validuser.username
                                      }
                                    }, as: :json
    assert_response 201, "response should be created 201"
  end
  test "should not create an invalid user" do
    skip    
    post api_v1_users_path, params: {user:
                                      {
                                        name:@invaliduser.name,
                                        password:@invaliduser.password
                                       }
                                    }, as: :json
    assert_response 400, "response should be Bad Request 400"
  end
end