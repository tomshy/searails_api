require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase
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
  test "valid user" do  	  	
  	assert @validuser.valid?, "user not valid"
  end  
  test "valid user without email" do
  	refute_nil @invaliduser.email?, "should have valid email"
  end
end
