module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: UsersRepresenter.new(User.all)
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        @user.save
        log_in @user
        render json: UserRepresenter.new(@user)
      end

      private

      def user_params
        params.require(:user).permit(:username, :firstname, :lastname, :password, :password_confirmation, :email)
      end
    end
  end
end
