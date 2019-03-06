# frozen_string_literal: true

require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @blog = blogs(:one)
    @user = users(:one)
  end

  test 'have a name' do
    refute_nil @blog.name, "blog doesn't have a name"
  end
  test 'blogs by user' do
    assert_equal 2, @user.blogs.size, 'a blog is created by user'
  end
end
