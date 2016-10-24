module Api
  module V1
    class GamesController < ApplicationController
      def index
        games = Game.select(:id, :name).all
        render json: GamesRepresenter.new(games)
      end
    end
  end
end
