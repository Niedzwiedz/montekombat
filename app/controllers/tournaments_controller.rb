class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update]
  def index
    @tournaments = Tournament.all
  end

  def show
  end

  def edit
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      respond_to do |format|
        format.html { redirect_to @tournament, notice: "Tournament was successfully created."}
      end
    else
      flash[:error] = @tournament.errors.full_messages
      render :new
    end
  end

  def update
    if @tournament.update_attributes(tournament_params)
      respond_to do |format|
        format.html { redirect_to @tournament, notice: "Tournament was successfully updated."}
      end
    else
      flash[:error] = @tournament.errors.full_messages
      render :edit
    end
  end

  def destroy
    Tournament.find(params[:id]).destroy
    flash[:success] = "Tournament deleted"
    redirect_to tournaments_path
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:game_id, :creator_id, :title, :description, :tournament_type, :number_of_teams, :number_of_players_in_team, :start_date)
  end
end
