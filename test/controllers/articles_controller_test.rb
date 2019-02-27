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
    #@blog_id=blogs(:one).id
    #@user_id=users(:one).id
    @auth_headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}"}
  end
  test "should get all articles of a blog" do
  	skip
    get api_v1_blog_articles_path(@article.id)
    assert_response :success
  end
  test "should create an article" do
  	skip
  	assert_difference -> {Article.count} do
    	post api_v1_blog_articles_path(blog_id:@article.blog_id), params: {article:{title:@article.body,body:@article.body,user_id:@article.user_id}}, as: :json, headers: @auth_headers
    end
    assert_response :success
  end
  test "should delete an article" do
  	skip
  	assert_difference -> {Article.count}, -1 do
    	delete api_v1_blog_article_path(blog_id:@article.blog_id,id:@article.id), as: :json, headers: @auth_headers
    end
    assert_response :success
  end
  test "should update an article" do
  	skip
    	patch api_v1_blog_article_path(blog_id:@article.blog_id,id:@article.id), params: {article:{title:"new title",body:"new body",author:@article.author}}, as: :json, headers: @auth_headers
    assert_response :success
  end
end
