# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @article = Article.new
  end

  test 'should have a title' do
    assert_not @article.save, 'Saving the article without a title'
  end
end
