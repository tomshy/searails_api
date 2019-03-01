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
				@user=User.find(params[:user_id])
				@blog=Blog.new(blog_params)
				@user.blogs << @blog			
				#binding.pry
				if @blog.save

					render json: {blog:{id:@blog.id, name:@blog.name},
								  message:"Created Successfully",
								  }, :status => :created
				else
					render json: {error:"Blog Not Created", :status => :bad_request}
				end
			end
			def destroy
				@user=User.find(params[:user_id])
				@blog=@user.blogs.find(params[:id])
				if @blog.destroy
					@blogs=Blog.all
					render json: @blogs
				else
					render json: {error:"Failed"}
				end
			end
			private
			def blog_params
				params.require(:blog).permit(:name)
			end
		end
	end
end