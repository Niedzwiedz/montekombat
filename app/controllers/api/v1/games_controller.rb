module Api
  module V1
    class GamesController < ApplicationController
      def index
        games = Game.all
        render json: GamesRepresenter.new(games)
      end
    end
  end
end
