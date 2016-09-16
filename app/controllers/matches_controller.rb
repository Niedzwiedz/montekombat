class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update]
  def index
    @matches = Match.includes(:game, :team_1, :team_2)
  end

  def show
  end

  def edit
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      respond_to do |format|
        format.html { redirect_to @match, notice: "Match was successfully created." }
      end
    else
      flash[:error] = @match.errors.full_messages
      render :new
    end
  end

  def update
    if @match.update_attributes(match_params)
      respond_to do |format|
        format.html { redirect_to @match, notice: "Match was successfully updated." }
      end
    else
      flash[:error] = @match.errors.full_messages
      render :edit
    end
  end

  def destroy
    Match.find(params[:id]).destroy
    flash[:success] = "Match deleted"
    redirect_to matches_path
  end

  private

  def set_match
    @match = Match.includes(:game, :team_1, :team_2).find(params[:id])
  end

  def match_params
    params.require(:match).permit(:game_id, :team_1_id, :team_2_id, :points_for_team1, :points_for_team2, :date, :status, :match_type)
  end
end
