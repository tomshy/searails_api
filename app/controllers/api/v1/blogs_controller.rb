module Api
	module V1
		class BlogsController < ApplicationController
			include ActionController::HttpAuthentication::Basic::ControllerMethods
			http_basic_authenticate_with name: "user", password: "secret", except: :index
			def index
				@blogs=Blog.all
				render json: @blogs
			end
			def create
				@blog=Blog.new(blog_params)
				if @blog.save
					render json: {blog:{name:@blog.name},
								  message:"Created Successfully",
								  status: 201}
				else
					render json: {error:"Blog Not Created"}
				end
			end
			def destroy
				@blog=Blog.find(params[:id])
				if @blog.destroy
					@blogs=Blog.all
					render json: @blogs
				else
					render json: {error:"Failed"}
				end
			end
			private
			def blog_params
				params.require(:blog).permit(:name, :user_id)
			end
		end
	end
end