module Api
	module V1
		class UserController < ApplicationController
			def index
				@users=User.all
				render json: @users
			end
			def create
				@user=User.new(user_parameters)
				if @user.save
					render json: {user:{name:@user.name,email:@user.email},
								  status: 201
								  }	
				else 
					render json: {error:{message:"Bad Request", status: 400}}
				end
			end
			private
			def user_parameters
				params.require(:user).permit(:name,:email,:password)
			end
		end
	end
	module V2
		#version 2
	end
end