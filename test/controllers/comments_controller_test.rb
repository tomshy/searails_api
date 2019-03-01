require 'test_helper'
require "faker"

class CommentsControllerTest < ActionDispatch::IntegrationTest
	include FactoryBot::Syntax::Methods
	#binding.pry
  	FactoryBot.define do
  		factory :comment do
  			body  {Faker::Lorem.sentence}
  			user_id {User.last.id || association(:user)}
  			article_id {Article.last.id || association(:article)}        
  		end
  	end
    
  	def setup
  		@comment=create(:comment)
  		@headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}","Content-Type"=>"application/vnd.api+json"}      
  	end
  test "should get all comments of an article" do
  	#skip
    get api_v1_user_blog_article_comments_path(user_id:@comment.user_id,blog_id:Blog.last.id,article_id:@comment.article_id), headers: @headers
    assert_response :success
  end
  test "should create a comment" do
  	#skip
    #binding.pry
  	assert_difference -> {Comment.count} do
    	create(:comment)
    end
  end
  test "should delete a comment by id" do
  	#binding.pry
  	#skip
  	assert_difference -> {Comment.count}, -1 do
    	delete api_v1_user_blog_article_comment_path(user_id:@comment.user_id,blog_id:Blog.last.id,article_id:@comment.article_id,id:@comment.id), headers: @headers
    end
    assert_response :success
  end
  test "should update a comment" do
  	#skip
    	patch api_v1_user_blog_article_comment_path(user_id:@comment.user_id,blog_id:Blog.last.id,article_id:@comment.article_id,id:@comment.id), params: {comment: {body:"new body"}},as: :json, headers: @headers      
    assert_response :success
  end
end
