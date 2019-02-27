require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  include FactoryBot::Syntax::Methods
  def setup
  	#FactoryBot.define do
  	#	factory :user do
  	#		name {Faker::Name.name}
  	#		email {Faker::Internet.email} 
  	#	end
  	#end
  	@user=users(:one)
  	#@user=User.new(:user)
  end
  test "valid user" do  	  	
  	assert @user.valid?, "user not valid"
  end
  test "invalid user without name" do
  	refute_nil @user.name, "name cannot be nil"
  end
  test "valid user without email" do
  	refute_nil @user.email, "should have valid email"
  end
end
