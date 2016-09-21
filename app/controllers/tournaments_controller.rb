class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :user_is_creator]

  before_action :logged_in_user, only: [:new, :create, :user_is_creator, :administrator, :delete]

  before_action :user_is_creator, only: [:edit, :update, :delete]
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
    @tournament.creator = current_user
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
    unless @tournament.ended?
      if @tournament.open?
        edit_params = tournament_params
      elsif @tournament.started?
        edit_params = tournament_started_params
      end
      if @tournament.update_attributes(edit_params)
        respond_to do |format|
          format.html { redirect_to @tournament, notice: "Tournament was successfully updated."}
        end
      else
        flash[:error] = @tournament.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    tournament = Tournament.find(params[:id])
    if tournament.open?
      tournament.destroy
      flash[:success] = "Tournament deleted"
    else
      flash[:error] = "You can't delete tournament that has already ended"
    end
    redirect_to tournaments_path
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def user_is_creator
    creator = @tournament.creator
    redirect_to root_path if current_user != creator and !current_user.admin?
  end

  def tournament_params
    params.require(:tournament).permit(:game_id, :creator_id, :title, :description,
                                       :tournament_type, :number_of_teams,
                                       :number_of_players_in_team, :start_date)
  end

  def tournament_started_params
    params.require(:tournament).permit(:title, :description)
  end
end
