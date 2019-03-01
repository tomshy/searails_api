module Api
	module V1
		class CommentsController < ApplicationController
			include ActionController::HttpAuthentication::Basic::ControllerMethods
			http_basic_authenticate_with name: "user", password: "secret", except: :index
			def index
					@user=User.find(params[:user_id])
					@blog=@user.blogs.find(params[:blog_id])
				  	@article=@blog.articles.find(params[:article_id])
				  	@comments=@article.comments.all
				  	render json: @comments
				  end
			def create
				@user=User.find(params[:user_id])
				@blog=@user.blogs.find(params[:blog_id])
				@article=@blog.articles.find(params[:article_id])			  	
			  	@comment=Comment.new(comment_params)
					if @comment.save
						render json: {article:{body:@comment.body},
									  message:"Created Successfully",
									  status: 201}
					else
						render json: {error:"Not created"}
					end 
			end		 
			def destroy
				@user=User.find(params[:user_id])
				@blog=@user.blogs.find(params[:blog_id])
				@article=@blog.articles.find(params[:article_id])			  	
			   	@comment = @article.comments.find(params[:id])
			   	if !@comment.nil?
			    	if @comment.destroy
			    		render json: @article.comments.all
			   		else
			   			render json: {error:"An error occurred."}
			   		end
			   	else
			   		render json: {error: "Not Found"}
			   	end
			end
			def update
				@user=User.find(params[:user_id])
				@blog=@user.blogs.find(params[:blog_id])
				@article=@blog.articles.find(params[:article_id])			 	
			   	@comment = @article.comments.find(params[:id])
			   	if @comment.update(comment_params)			   		
			   		render json: @comment			   				   		
			   	else
			   		render json: {error:"Error occurred",status: :not_modified}
			   	end
			end
			private
			def comment_params
			  	params.require(:comment).permit(:body)
			end
		end
	end
end