class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :check_if_user_is_creator,
                                        :destroy]
  before_action :check_if_logged_in_user, only: [:new, :create, :check_if_user_is_creator]
  before_action :check_if_user_is_creator, only: [:edit, :update, :destroy]

  def index
    @tournaments = Tournament.all
  end

  def types
    @types = Tournament.tournament_types.keys.to_a
    respond_to do |format|
      format.json { render json: @types }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @tournament }
    end
  end

  def edit
  end

  def new
    @tournament = Tournament.new
    @tournament.teams.build
  end

  def create
    @tournament = InitializeTournament.call(tournament_params, teams_params)
    if @tournament.instance_of? Tournament
      respond_to do |format|
        format.html do
          redirect_to @tournament,
                      notice: "Tournament was successfully created."
        end
      end
    else
      flash[:error] = @tournament.message
      render :new
    end
  end

  def update
    unless @tournament.ended?
      if @tournament.update_attributes(edit_params(@tournament))
        respond_to do |format|
          format.html do
            redirect_to @tournament,
                        notice: "Tournament was successfully updated."
          end
        end
      else
        flash[:error] = @tournament.errors.full_messages
        render :edit
      end
    else
      flash[:error] = "Tournament that ended can't be edited."
      render :edit
    end
  end

  def destroy
    if @tournament.open?
      @tournament.destroy
      flash[:success] = "Tournament deleted."
    else
      flash[:error] = "You can't delete tournament that has already ended."
    end
    redirect_to tournaments_path
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def check_if_logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def check_if_user_is_creator
    creator_id = @tournament.creator.id
    redirect_to root_path if current_user.id != creator_id && !current_user.admin?
  end

  def tournament_params
    params.require(:tournament).permit(:id, :game_id, :creator_id, :title, :description,
                                       :tournament_type, :number_of_teams,
                                       :number_of_players_in_team, :start_date)
  end

  def teams_params
    params.require(:teams).permit!
  end

  def tournament_started_params
    params.require(:tournament).permit(:title, :description)
  end

  # ------------------------------------------------------------------
  # edit_params(tournament) - changes params that can be edited
  # dependant on tournament status.
  # ------------------------------------------------------------------
  def edit_params(tournament)
    if tournament.open?
      tournament_params
    elsif tournament.started?
      tournament_started_params
    end
  end
end
