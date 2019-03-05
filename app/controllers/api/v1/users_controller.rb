module Api
	module V1
		class UsersController < ApplicationController
			
			def index
				@users=User.all
				render json: @users
			end
			def create
				@user=User.new(user_parameters)
				if @user.save
					render json: {user:{name:@user.name,email:@user.email,username:@user.username}								  
								  }, :status => :created	
				else 
					render json: {error:{message:"Bad Request"}}, :status => :bad_request
				end
			end
			private
			def user_parameters
				params.require(:user).permit(:name,:email,:password,:username)
			end
		end
	end
	module V2
		#version 2
	end
end