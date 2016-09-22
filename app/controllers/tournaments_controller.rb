class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :user_is_creator,
                                        :destroy]

  before_action :logged_in_user, only: [:new, :create, :user_is_creator]

  before_action :user_is_creator, only: [:edit, :update, :destroy]
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
        format.html do
          redirect_to @tournament,
                      notice: "Tournament was successfully created."
        end
      end
    else
      flash[:error] = @tournament.errors.full_messages
      render :new
    end
  end

  def update
    unless @tournament.ended?
      # ------------------------------------------------------------------
      # edit_params(tournament) - changes params that can be edited dependant on
      # tournament status. Needs tests.
      # ------------------------------------------------------------------
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

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def user_is_creator
    creator_id = @tournament.creator.id
    redirect_to root_path if current_user.id != creator_id and !current_user.admin?
  end

  def tournament_params
    params.require(:tournament).permit(:game_id, :creator_id, :title, :description,
                                       :tournament_type, :number_of_teams,
                                       :number_of_players_in_team, :start_date)
  end

  def tournament_started_params
    params.require(:tournament).permit(:title, :description)
  end

  def edit_params(tournament)
    if tournament.open?
      tournament_params
    elsif tournament.started?
      tournament_started_params
    end
  end
end
