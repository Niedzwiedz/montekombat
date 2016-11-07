class TeamsController < ApplicationController
  before_action :check_if_logged_in_user, only: [:new, :create, :edit, :update,
                                                 :edit_teams, :check_if_user_is_creator,
                                                 :add_user, :remove_user]
  before_action :check_if_user_is_creator, only: [:destroy]

  def edit
    team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.tournament.creator == current_user
      @user = User.find(user_params)
      @team.users.build(@user.attributes)
    else
      @team.users.build(current_user.attributes)
    end
    if @team.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Team was successfully created." }
        format.json { render json: TeamRepresenter.new(@team) }
      end
    else
      flash[:error] = @team.errors.full_messages
      render :new
    end
  end

  def update
    if team.update(team_params)
      respond_to do |format|
        format.html { redirect_to matches_path, notice: "Team was successfully updated." }
      end
    else
      flash[:error] = team.errors.full_messages
      render :edit
    end
  end

  def destroy
    team.destroy
    render json: {}, status: :no_content
  end

  # Additional actions

  def add_user
    team = Team.find(params[:team_id])
    if team.tournament.creator == current_user
      user = User.find(params[:user_id])
      team.users << user
    else
      team.users << current_user
    end
    render json: {}
  end

  def remove_user
    team = Team.find(params[:team_id])
    if team.tournament.creator == current_user
      user = User.find(params[:user_id])
      team.users.delete(user)
    else
      team.users.delete(current_user)
    end
    unless team.users.any?
      team.destroy!
    end
    render json: {}, status: :no_content
  end

  private

  def check_if_logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def check_if_user_is_creator
    creator_id = team.tournament.creator.id
    redirect_to root_path if current_user.id != creator_id && !current_user.admin?
  end

  def team
    @team ||= Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :tournament_id)
  end

  def user_params
    params.require(:user).permit(:id, :username, :firstname, :lastname, :password, :password_confirmation, :email)
  end
end
