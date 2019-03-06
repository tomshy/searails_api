# frozen_string_literal: true

require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  def setup
    @validuser = create(:user, :validuser)
    @invaliduser = create(:user, :invaliduser)
  end
  test 'valid user' do
    assert @validuser.valid?, 'user not valid'
  end
  test 'valid user without email' do
    refute_nil @invaliduser.email?, 'should have valid email'
  end
end
