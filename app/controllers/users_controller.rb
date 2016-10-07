class UsersController < ApplicationController
  # Check if user is logged in
  before_action :logged_in_user, only: [:index, :edit, :update, :users_index]
  # Check if user has rights to change something
  before_action :correct_user, only: [:edit, :update, :destroy]
  # Administrator
  before_action :administrator, only: [:index]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  # Returns only usernames with indexes, so passwords and other
  # data is safe
  def users_index
    @users = User.select("username, id").all
    respond_to do |format|
      format.json { render json: @users }
    end
  end

  def show
    user
  end

  def edit
    user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      respond_to do |format|
        format.html { redirect_to @user, notice: "User signed up."}
      end
    else
      render :new
    end
  end

  def update
    if user.update_attributes(user_params)
      respond_to do |format|
        format.html { redirect_to user, notice: "Account updated."}
      end
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to users_path
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user or current_user.admin?
  end

  def administrator
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :password, :password_confirmation, :email)
  end
end
