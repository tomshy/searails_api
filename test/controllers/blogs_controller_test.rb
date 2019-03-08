# frozen_string_literal: true

require 'test_helper'
require 'faker'
class BlogControllerTest < ActionDispatch::IntegrationTest
  def setup
    @blog = create(:blog, :validblog)
    
    @auth_headers = { 'Authorization' => "Basic #{Base64.encode64('user:secret')}" }
   end
  test 'create new blog by registered user' do    
      assert_difference -> { Blog.count } do
        post api_v1_blogs_path, params: { blog:
                                          {
                                            name: @blog.name
                                          } 
                                        }, as: :json, headers: @auth_headers
      end
    assert_response 201
  end  
  test 'retrieve all blogs' do    
      get api_v1_blogs_path, as: :json    
    assert_response 200    
  end
  test 'delete a blog by id' do    
      assert_difference -> { Blog.count }, -1 do
        delete api_v1_blog_path(id: @blog.id), as: :json, headers: @auth_headers
      end    
    assert_response 200
  end
end
