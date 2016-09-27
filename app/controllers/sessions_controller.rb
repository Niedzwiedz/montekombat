class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash[:error] = "Username or password not correct."
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
