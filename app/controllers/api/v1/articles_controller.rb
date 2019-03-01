module Api
	module V1
		class ArticlesController < ApplicationController
			include ActionController::HttpAuthentication::Basic::ControllerMethods
			http_basic_authenticate_with name: "user", password: "secret", except: :index
		  def index
		  	@blog=Blog.find(980190962)
		  	#@article=Article.find(params[:id])
		  	@articles=@blog.articles.all
		  	render json: @articles
		  end
		  def create
		  	@user = User.find(params[:user_id])
		  	@blog = @user.blogs.find(params[:blog_id])		  	
		  	@article=Article.new(article_params)
		  	@blog.articles << @article
				if @article.save
					render json: {article:{title:@article.title, body:@article.body, blog: @blog.id, author: @user.id },								  
								  status: :created}
				else
					render json: {error:"Not created"}
				end 
		  end
		  def show
		  	@user = User.find(params[:user_id])
		  	@blog = @user.blogs.find(params[:blog_id])
	    	@article = @blog.articles.find(params[:id])
	    	render json: @article
		  end
		  def destroy
		  	@user = User.find(params[:user_id])
		  	@blog = @user.blogs.find(params[:blog_id])	    		
	    	@article = @blog.articles.find(params[:id])
	    	if !@article.nil?
		    	if @article.destroy
		    		render json: @blog.articles.all
	    		else
	    			render json: {error:"An error occurred."}
	    		end
	    	else
	    		render json: {error: "Not Found"}
	    	end
		  end
		  def update
		  	@user = User.find(params[:user_id])
		  	@blog = @user.blogs.find(params[:blog_id])
	    	@article = @blog.articles.find(params[:id])
	    	if @article.update(article_params)
	    		render json: @article
	    	else
	    		render json: {error:"Error occurred"}
	    	end
		  end
		  private
		  def article_params
		  	params.require(:article).permit(:title,:body)
		  end
		end
	end
end