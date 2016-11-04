class TournamentsController < ApplicationController
  before_action :check_if_logged_in_user, only: [:new, :create, :edit, :update,
                                                 :edit_teams, :check_if_user_is_creator]
  before_action :check_if_user_is_creator, only: [:update, :destroy]

  def index
    @tournaments = Tournament.all
  end

  def show
    tournament
    respond_to do |format|
      format.html
      format.json { render json: TournamentRepresenter.new(tournament) }
    end
  end

  def edit
    tournament
  end

  def edit_teams
  end

  def new
    @tournament = Tournament.new
    @tournament.teams.build
  end

  def create
    @tournament = InitializeTournament.call(tournament_params, teams_params, current_user)
    if @tournament.instance_of? Tournament
      respond_to do |format|
        format.html do
          redirect_to @tournament,
                      notice: "Tournament was successfully created."
        end
        format.json do
          flash[:error] = "Tournament created."
          render json: TournamentRepresenter.new(tournament)
        end
      end
    else
      flash[:error] = @tournament.message
    end
  end

  def update
    unless tournament.ended?
      begin
        tournament.update!(edit_params(tournament))
        respond_to do |format|
          format.html do
            redirect_to tournament,
                        notice: "Tournament was successfully updated."
          end
          format.json do
            render json: TournamentRepresenter.new(tournament)
          end
        end
      rescue ActiveRecord::RecordInvalid
        flash[:error] = tournament.errors.full_messages
        render :edit
      end
    else
      flash[:error] = "Tournament that ended can't be edited."
      render :edit
    end
  end

  def destroy
    if tournament.open?
      tournament.destroy
      flash[:success] = "Tournament deleted."
    else
      flash[:error] = "You can't delete tournament that has started or already ended."
    end
    redirect_to tournaments_path
  end

  # ------------------------------------------------------------------
  # Additional actions (types, add_team)

  def types
    @types = Tournament.tournament_types.keys.to_a
    respond_to do |format|
      format.json { render json: @types }
    end
  end

  private

  def tournament
    @tournament ||= Tournament.find(params[:id])
  end

  def check_if_logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def check_if_user_is_creator
    creator_id = tournament.creator.id
    redirect_to root_path if current_user.id != creator_id && !current_user.admin?
  end

  def tournament_params
    params.require(:tournament).permit(:game_id, :creator_id, :title, :description,
                                       :tournament_type, :number_of_teams,
                                       :number_of_players_in_team, :start_date)
  end

  def team_params
    params.require(:team).permit(:name)
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
