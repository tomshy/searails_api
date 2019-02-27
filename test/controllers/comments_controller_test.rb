require 'test_helper'
require "faker"

class CommentsControllerTest < ActionDispatch::IntegrationTest
	include FactoryBot::Syntax::Methods
	#binding.pry
  	FactoryBot.define do
  		factory :comment do
  			body  {Faker::Lorem.sentence}
  			user_id {User.last.id || association(:user)}
  			article_id {Article.first.id || association(:article)}
  		end
  	end
  	def setup
  		@comment=create(:comment)
  		@auth_headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}"}
  	end
  test "should get all comments of an article" do
  	skip
    get api_v1_article_comments_path(article_id:@comment.article_id), as: :json
    assert_response :success
  end
  test "should create a comment" do
  	skip
  	assert_difference -> {Article.count} do
    	post api_v1_article_comments_path(article_id:@comment.article_id),
	    	params: {comment:
			    		{
			    			body:@comment.body,
			    			user_id: @comment.user_id			    			
			    		}
			    	},
	    	as: :json, headers: @auth_headers
    end
    assert_response :success
  end
  test "should delete a comment by id" do
  	#binding.pry
  	skip
  	assert_difference -> {Article.count}, -1 do
    	delete api_v1_article_comments_path(article_id:@comment.article_id,id:@comment.id), headers: @auth_headers
    end
    assert_response :success
  end
  test "should update an article" do
  	skip
    	patch api_v1_blog_article_path(blog_id:@article.blog_id,id:@article.id), params: {article:{title:"new title",body:"new body",author:@article.author}}, as: :json, headers: @auth_headers
    assert_response :success
  end
end
