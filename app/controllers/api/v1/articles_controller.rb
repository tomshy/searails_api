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
					render json: {article:{id: @article.id, title:@article.title, body:@article.body, blog: @blog.id, author: @article.user_id }},
								  status: 201
				else
					render json: {message:"Bad Request"}, status: 400
				end 
		  end
		  def show		  			  	
	    	@article = Article.find(params[:id])
	    	render json: @article, status: 200
		  end
		  def destroy
		  	@articles=Article.all	  			  	
	    	@article = Article.find(params[:id])
	    	if @article.destroy
		    	render json: @articles, status: 200
	    	else
	    		render json: {message:"Wrong article ID"}, status: 404
	    	end	    	
		  end
		  def update		  			  	
	    	@article = Article.find(params[:id])
	    	if @article.update(article_params)
	    		render json: @article, status: 200
	    	else
	    		render json: {message:"Wrong article ID"}, status: 404
	    	end
		  end
		  private
		  def article_params
		  	params.require(:article).permit(:title,:body)
		  end
		end
	end
end