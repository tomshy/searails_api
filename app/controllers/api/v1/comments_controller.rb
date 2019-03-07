# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      http_basic_authenticate_with name: 'user', password: 'secret', except: :index
      before_action :create_user, only: [:create]
      before_action :get_article, only: [:index, :create]
      before_action :get_comment, only: [:destroy, :update]
      def index        
        @comments = @article.comments.all
        render json: @comments
       end
      def create        
        @comment = Comment.new(comment_params)
        @comment.user_id = @user
        @article.comments << @comment
        if @comment.save
          render json: { comment: { id: @comment.id,
                                    body: @comment.body,
                                    commenter: @comment.user_id } }, status: 201
        else
          render json: { message: 'Not created' }, status: 400
        end
      end
      def destroy
        if @comment.destroy
          render json: Comment.all, status: 200
        else
          render json: { message: 'Wrong comment ID' }, status: 404
        end
      end
      def update
        if @comment.update(comment_params)
          render json: @comment, status: 200
        else
          render json: { message: 'Wrong comment ID' }, status: 404
        end
      end

      private
      def comment_params
        params.require(:comment).permit(:body)
      end

      def get_article
        @article = Article.find(params[:article_id])
      end
      def get_comment
        @comment = Comment.find(params[:id])
      end
    end
  end
end
