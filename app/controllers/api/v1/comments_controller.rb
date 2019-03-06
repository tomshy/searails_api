module Api
	module V1
		class CommentsController < ApplicationController			
			http_basic_authenticate_with name: "user", password: "secret", except: :index
			before_action :create_user
			def index					
				  	@article=Article.find(params[:article_id])
				  	@comments=@article.comments.all
				  	render json: @comments
				  end
			def create
				@article=Article.find(params[:article_id])
			  	@comment=Comment.new(comment_params)
				@comment.user_id=@user				  	
			  	@article.comments << @comment
					if @comment.save						
						render json: {comment:{id: @comment.id,
											   body:@comment.body,
									           commenter:@comment.user_id
									  }}, status: 201
					else
						render json: {message:"Not created"}, status: 400
					end 
			end		 
			def destroy							
			   	@comment = Comment.find(params[:id])			   	
			    if @comment.destroy
			    	render json: Comment.all, status: 200			    	
			   	else
			   		render json: {message:"Wrong comment ID"}, status: 404
			   	end			   	
			end
			def update				
			   	@comment = Comment.find(params[:id])
			   	if @comment.update(comment_params)			   		
			   		render json: @comment, status: 200			   				   		
			   	else
			   		render json: {message:"Wrong comment ID"}, status: 404
			   	end
			end
			private
			def comment_params
			  	params.require(:comment).permit(:body)
			end
		end
	end
end