class UsersController < ApplicationController
  # Check if user is logged in
  before_action :logged_in_user, only: [:index, :edit, :update]
  # Check if user has rights to change something
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]
  # Administrator
  before_action :administrator, only: [:index]
  def index
    @users = User.all
  end

  def show
  end

  def edit
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
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.html { redirect_to @user, notice: "Account updated."}
      end
    else
      render :edit
    end
  end

  def destroy
    User.find(parmas[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
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
