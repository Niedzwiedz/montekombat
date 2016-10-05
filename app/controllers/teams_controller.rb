class TeamsController < ApplicationController

  def edit
    team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Team was successfully created." }
        format.json { render json: @team }
      end
    else
      flash[:error] = @team.errors.full_messages
      render :new
    end
  end

  def update
    if team.update_attributes(team_params)
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
    render json: {}, status: :no_content
  end

  def remove_user
    team = Team.find(params[:team_id])
    team.users.find(params[:user_id]).delete
    render json: {}, status: :no_content
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
