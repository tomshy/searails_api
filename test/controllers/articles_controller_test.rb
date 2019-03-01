require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
	include FactoryBot::Syntax::Methods
	#binding.pry
  	FactoryBot.define do
  		factory :article do
  			title {Faker::Name.name}
  			body	{Faker::Lorem.sentence}
        blog_id {Blog.first.id || association(:blog)}
        user_id {User.first.id || association(:user)}
  		end
  	end
  def setup
  	@article=create(:article)    
    @headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}","Content-Type"=>"application/vnd.api+json"}
  end
  test "should get all articles of a blog" do
  	#skip
    get api_v1_user_blog_articles_path(user_id:@article.user_id,blog_id:@article.blog_id)
    assert_response :success
  end
  test "should create an article" do
  	#skip
  	assert_difference -> {Article.count} do
    	create(:article)
      #binding.pry
    end        
  end
  test "should retrieve an article by id" do
    get api_v1_user_blog_article_path(user_id:@article.user_id,blog_id:@article.blog_id,id:@article.id), headers: @headers
  end
  test "should delete an article" do
  	#skip
  	assert_difference -> {Article.count}, -1 do
    	delete api_v1_user_blog_article_path(user_id:@article.user_id,blog_id:@article.blog_id,id:@article.id), headers: @headers
    end
    assert_response :success
  end
  test "should update an article" do
  	
    	patch api_v1_user_blog_article_path(user_id:@article.user_id,blog_id:@article.blog_id,id:@article.id), params: {article:{title:"new title",body:"new body"}},as: :json, headers: @headers      
    assert_response :success
  end
end
