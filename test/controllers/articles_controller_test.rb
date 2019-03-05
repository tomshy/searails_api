require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  	
  def setup
  	@article=create(:article)    
    @auth_headers={"Authorization"=>"Basic #{Base64.encode64('user:secret')}"}
  end
  test "should get all articles of a blog" do
  	#skip
    get api_v1_blog_articles_path(blog_id:@article.blog_id), as: :json
    assert_response :success
  end
  test "should create an article" do
  	#skip
  	assert_difference -> {Article.count} do
    	post api_v1_blog_articles_path(blog_id:@article.blog_id), 
                                              params: {article:
                                                        {
                                                          title:"attractive title",
                                                          body:"long body"
                                                        }
                                                      }, as: :json, headers: @auth_headers
    end        
  end
  test "should retrieve an article by id" do
    get api_v1_article_path(id:@article.id), as: :json
  end
  test "should delete an article" do
  	#skip
  	assert_difference -> {Article.count}, -1 do
    	delete api_v1_article_path(id:@article.id), as: :json, headers: @auth_headers
      #binding.pry
    end
    assert_response :success
  end
  test "should update an article" do  	
    	patch api_v1_article_path(id:@article.id), params: {article:
                                                          {title:"new title",
                                                           body:"new body"
                                                          }
                                                         },as: :json, headers: @auth_headers
    assert_response :success
  end
end
