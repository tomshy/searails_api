class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Basic::ControllerMethods	
	def create_user
		@user=User.last.id
	end
end
