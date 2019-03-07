# frozen_string_literal: true

require 'test_helper'
require 'faker'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = create(:comment)
    @auth_headers = { 'Authorization' => "Basic #{Base64.encode64('user:secret')}" }
   end
  test 'should get all comments of an article' do
    get api_v1_article_comments_path(article_id: @comment.article_id), as: :json, headers: @auth_headers
    assert_response :success
  end
  test 'should create a comment' do
    #skip
    # binding.pry
    assert_difference -> { Comment.count } do
      post api_v1_article_comments_path(article_id: @comment.article_id), params: { comment:
                                                                                    { body: @comment.body } }, as: :json, headers: @auth_headers      
    end
    assert_response :created
  end
  test 'should delete a comment by id' do
    # binding.pry
    # skip
    assert_difference -> { Comment.count }, -1 do
      delete api_v1_comment_path(id: @comment.id), as: :json, headers: @auth_headers
    end
    assert_response :success
  end
  test 'should update a comment' do
    # skip
    patch api_v1_comment_path(id: @comment.id), params: { comment: { body: 'new body' } }, as: :json, headers: @auth_headers
    assert_response :success
  end
end
