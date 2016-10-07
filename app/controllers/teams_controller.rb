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
      end
    else
      flash[:error] = @team.errors.full_messages
      render :new
    end
  end

  def add_user
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

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
