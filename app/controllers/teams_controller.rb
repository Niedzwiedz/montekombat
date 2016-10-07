class TeamsController < ApplicationController

  def edit
    team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @user = User.find(user_params)
    @team.users << @user
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
    user = User.find(params[:user_id])
    team.users << user
    render json: {}
  end

  def remove_user
    team = Team.find(params[:team_id])
    user = User.find(params[:user_id])
    team.users.delete(user)
    unless team.users.any?
      team.destroy!
    end
    render json: {}, status: :no_content
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :tournament_id)
  end

  def user_params
    params.require(:user)
  end
end
