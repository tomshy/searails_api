# frozen_string_literal: true

module Api
  module V1
    class BlogsController < ApplicationController
      http_basic_authenticate_with name: 'user', password: 'secret', except: :index
      before_action :create_user, only: [:create]
      before_action :get_blogs, only: [:index, :destroy]
      def index        
        render json: @blogs
      end
      def create
        @blog = Blog.new(blog_params)
        @blog.user_id = @user
        if @blog.save
          render json: { blog: { id: @blog.id, name: @blog.name },
                         message: 'Created Successfully' }, status: 201
        else
          render json: { message: 'Blog Not Created' }, status: 400
        end
      end
      def destroy        
        @blog = @blogs.find(params[:id])
        if @blog.destroy
          render json: @blogs
        else
          render json: { message: 'Wrong Blog ID' }, status: 404
        end
      end
      private
      def blog_params
        params.require(:blog).permit(:name)
      end

      def get_blogs
        @blogs = Blog.all
      end
    end
  end
end
