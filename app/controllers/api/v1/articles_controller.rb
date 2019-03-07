# frozen_string_literal: true

module Api
  module V1    
    class ArticlesController < ApplicationController
      http_basic_authenticate_with name: 'user', 
                                   password: 'secret', except: :index
      before_action :create_user, only: [:create]
      before_action :get_all_articles, only: [:destroy]
      before_action :get_article, only: [:show, :destroy, :update]
      before_action :get_blog, only: [:index, :create]
      def index        
        @articles = @blog.articles.all
        render json: @articles
      end
      def create
        @article = Article.new(article_params)
        @article.user_id = @user
        @blog.articles << @article
        if @article.save
          render json: { article: { 
                                    id: @article.id, 
                                    title: @article.title, 
                                    body: @article.body, 
                                    blog: @blog.id, 
                                    author: @article.user_id 
                                  } 
                        },
                        status: 201
        else
          render json: { message: 'Bad Request' }, status: 400
        end
      end
      def show
        render json: @article, status: 200
      end
      def destroy
        if @article.destroy
          render json: @articles, status: 200
        else
          render json: { message: 'Wrong article ID' }, status: 404
        end
       end
      def update
        if @article.update(article_params)
          render json: @article, status: 200
        else
          render json: { message: 'Wrong article ID' }, status: 404
        end
      end

      private
      def article_params
        params.require(:article).permit(:title, :body)
      end

      def get_all_articles
        @articles=Article.all
      end
      def get_article        
        @article=Article.find(params[:id])
      end
      def get_blog
         @blog = Blog.find(params[:blog_id])
      end 
    end
  end
end
