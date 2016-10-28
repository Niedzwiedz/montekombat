module Api
  module V1
    class TeamsController < ApplicationController

      def index
        render json: TeamsRepresenter.new(Team.all)
      end

      def edit
        render json: TeamRepresenter.new(team)
      end

      def new
        team = Team.new
        render json: TeamRepresenter.new(team)
      end

      def create
        team = Team.new(team_params)
        user = User.find(user_params)
        team.users << user
        team.save!
        render json: TeamRepresenter.new(team)
      end

      def update
        team.update(team_params)
        render json: TeamRepresenter.new(team)
      end

      def destroy
        team.delete_team_from_matches
        team.delete_empty_matches
        team.destroy
        head :ok
      end

      def add_user
        team = Team.find(params[:team_id])
        # if team.tournament.creator == current_user
        user = User.find(params[:user_id])
        team.users << user
        # else
        #   team.users << current_user
        # end
        render json: TeamRepresenter.new(team)
      end

      def remove_user
        team = Team.find(params[:team_id])
        # if team.tournament.creator == current_user
        user = User.find(params[:user_id])
        team.users.delete(user)
        # else
          # team.users.delete(current_user)
        # end
        unless team.users.any?
          team.delete_team_from_matches
          team.delete_empty_matches
          team.destroy!
        end
        render json: TeamRepresenter.new(team)
      end

      private

      def team
        @team ||= Team.find(params[:id])
      end

      def team_params
        params.require(:team).permit(:name, :tournament_id)
      end

      def user_params
        params.require(:user)
      end

    end
  end
end
