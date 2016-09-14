class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def edit
    @match = Match.find(params[:id])
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
      render :new
    end
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(match_params)
      respond_to do |format|
        format.html { redirect_to @match, notice: "Match was successfully updated." }
      end
    else
      render :edit
    end
  end

  def destroy
    Match.find(params[:id]).destroy
    flash[:success] = "Match deleted"
    redirect_to matches_url
  end

  private

  def match_params
    params.require(:match).permit(:game_id, :team_1_id, :team_2_id, :match_type)
  end
end
