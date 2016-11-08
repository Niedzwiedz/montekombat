module Api
  module V1
    class MatchesController < ApplicationController
      # before_action :authenticate_user

      def index
        render json: MatchesRepresenter.new(Match.all)
      end

      def show
        render json: MatchRepresenter.new(match)
      end

      def edit
        render json: MatchRepresenter.new(match)
      end

      def create
        @match = InitializeMatch.call(new_match_params, team_1_params, team_2_params, team1_users_params, team2_users_params)
        if @match.instance_of? Match
          render json: MatchRepresenter.new(@match)
        else
          render json: { error: @match }
        end
      end

      def update
        match.update_attributes(match_params)
        updated_match = UpdateMatch.call(match)
        render json: MatchRepresenter.new(updated_match)
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

      def match_params
        params_match = [:game_id, :team1, :team2, :status, :match_type, :points_for_team1, :points_for_team2] if match.friendly?
        params_match = [:points_for_team1, :points_for_team2, :status] if match.competetive?
        params.require(:match).permit(params_match)
      end

      def new_match_params
        params.require(:match).permit(:game_id, :creator)
      end

      def team_1_params
        params.require(:team_1).permit(:name)
      end

      def team1_users_params
        params.require(:users_for_team1).permit!
      end

      def team_2_params
        params.require(:team_2).permit(:name)
      end

      def team2_users_params
        params.require(:users_for_team2).permit!
      end
    end
  end
end
