class MatchesController < ApplicationController
  def index
    @matches = Match.includes(:game, :team_1, :team_2)
  end

  def show
    match
    respond_to do |format|
      format.html
      format.json { render json: MatchRepresenter.new(match)}
    end
  end

  def edit
    match
    respond_to do |format|
      format.html
      format.json { render json: MatchRepresenter.new(match)}
    end
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
    if match.update_attributes(match_params)
      respond_to do |format|
        format.html { redirect_to match, notice: "Match was successfully updated." }
      end
      if match.finished?
        match.remove_loser
        deathmatch_round_generator if match.last_match_in_round?
      end
    else
      flash[:error] = match.errors.full_messages
      render :edit
    end
  end

  def destroy
    Match.find(params[:id]).destroy
    flash[:success] = "Match deleted"
    redirect_to matches_path
  end

  # Additional actions
  def options
    statuses = Match.statuses.keys.to_a
    match_types = Match.match_types.keys.to_a
    render json: MatchesOptionsRepresenter.new(statuses, match_types)
  end

  private

  def match
    @match ||= Match.includes(:game, :team_1, :team_2).find(params[:id])
  end

  def ended_params
    []
  end

  def started_params
    ended_params << [:points_for_team1, :points_for_team2, :status]
  end

  def upcoming_params
    ended_params << [:status]
  end

  def upcoming_params_for_creator
    started_params << [:game_id, :team_1_id, :team_2_id, :date, :status]
  end

  def match_params
    # this_match_params = upcoming_params_for_creator if upcoming_match_and_creator?
    # this_match_params = upcoming_params if upcoming_match_and_member?
    # this_match_params = started_params if in_progress_match_and_member? || finished_match_and_creator?
    # this_match_params = ended_params if finished_match_and_member?
    params_match = [:game, :team1, :team2, :status, :match_type] if match.friendly?
    params_match = [:points_for_team1, :points_for_team2, :status] if match.competetive?
    params.require(:match).permit(params_match)
  end

  def upcoming_match_and_creator?
    match.upcoming? && match.creator?(current_user)
  end

  def upcoming_match_and_member?
    match.upcoming? && !match.creator?(current_user) && match.player?(current_user)
  end

  def in_progress_match_and_member?
    match.in_progress? && (match.player?(current_user) || match.creator?(current_user))
  end

  def finished_match_and_creator?
    match.creator?(current_user) && match.finished?
  end

  def finished_match_and_member?
    match.finished? && match.player?(current_user) && !match.creator?(current_user)
  end
end
