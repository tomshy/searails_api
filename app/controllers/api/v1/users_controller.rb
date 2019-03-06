# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def create
        @user = User.new(user_parameters)
        if @user.save
          render json: { user: { id: @user.id, name: @user.name, email: @user.email, username: @user.username } }, status: 201
        else
          render json: { message: 'Bad Request' }, status: 400
        end
      end

      private

      def user_parameters
        params.require(:user).permit(:name, :email, :password, :username)
      end
    end
  end
  module V2
    # version 2
  end
end
