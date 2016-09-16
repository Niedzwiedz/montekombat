class UsersController < ApplicationController
  # CALY CRUD, jak bedzie admin to beda zmiany
  # Widoki sa spartanskie ale dzialaja
  before_action :set_user, only: [:show, :edit, :update]
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
      respond_to do |format|
        format.html { redirect_to @user, notice: "User signed up."}
      end
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.html { redirect_to @user, notice: "Account updated."}
      end
    else
      flash[:error] = @user.errors.full_messages
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

  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :password, :email)
  end
end
