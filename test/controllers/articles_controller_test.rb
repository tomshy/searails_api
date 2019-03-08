# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = create(:article)
    @auth_headers = { 'Authorization' => "Basic #{Base64.encode64('user:secret')}" }
  end
  test 'should get all articles of a blog' do
    # skip
    get api_v1_blog_articles_path(blog_id: @article.blog_id), as: :json
    assert_response :success
  end
  test 'should create an article' do
    #skip
    assert_difference -> { Article.count } do
      post api_v1_blog_articles_path(blog_id: @article.blog_id),
           params: { article:
                     {
                       title: 'attractive title',
                       body: 'long body'
                     } 
                   }, as: :json, headers: @auth_headers
    end
    assert_response 201
  end
  test "should not create an article with invalid data like empty title field" do
    assert_no_difference -> {Article.count} do
      post api_v1_blog_articles_path(blog_id: @article.blog_id),
             params: { article:
                       {
                         title: '',
                         body: 'long body'
                       } 
                     }, as: :json, headers: @auth_headers
    end
    assert_response 400
  end 
  test 'should retrieve an article by id' do
    #skip
    get api_v1_article_path(id: @article.id), as: :json
    assert_response 200
  end
  test 'should delete an article' do
    #skip
    assert_difference -> { Article.count }, -1 do
      delete api_v1_article_path(id: @article.id), as: :json, headers: @auth_headers
      # binding.pry
    end
    assert_response :success
  end
  test 'should update an article' do
    @curr_article=Article.first     
    assert_changes 'Article.first.body' do
    patch api_v1_article_path(id: @curr_article.id), params: { article:
                                                         { title: 'new title',
                                                           body: 'new body' } }, as: :json, headers: @auth_headers
    
    end    
    assert_response :success
  end
end
