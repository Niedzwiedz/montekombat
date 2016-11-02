class GamesRepresenter < BaseRepresenter
  def initialize(games)
    @games = games
  end

  def basic
    @games.map do |game|
      GameRepresenter.new(game)
    end
  end
end
