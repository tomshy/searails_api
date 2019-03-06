module Api
	module V1
		class ArticlesController < ApplicationController			
			http_basic_authenticate_with name: "user", password: "secret", except: :index
			before_action :create_user
		  def index		  		  	
		   	@blog=Blog.find(params[:blog_id])		  	
		  	@articles=@blog.articles.all
		  	render json: @articles
		  end
		  def create		  	
		  	@blog = Blog.find(params[:blog_id])
		  	@article=Article.new(article_params)
		  	@article.user_id=@user
		  	@blog.articles << @article		  	
				if @article.save				
					render json: {article:{title:@article.title, body:@article.body, blog: @blog.id, author: @user.id },								  
								  status: :created}
				else
					render json: {error:"Not created"}
				end 
		  end
		  def show		  			  	
	    	@article = Article.find(params[:id])
	    	render json: @article
		  end
		  def destroy
		  	@articles=Article.all	  			  	
	    	@article = Article.find(params[:id])
	    	if @article.destroy
		    	render json: @articles
	    	else
	    		render json: {error:"An error occurred."}
	    	end	    	
		  end
		  def update		  			  	
	    	@article = Article.find(params[:id])
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