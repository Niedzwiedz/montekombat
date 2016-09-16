class SessionsController < ApplicationController
  # WORK IN PROGRESS
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])

    else
      flash[:error] = "This account doesn't exist"
      render :new
    end
  end

  def destroy
  end
end
