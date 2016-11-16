class GamesRepresenter
  def initialize(games)
    @games = games
  end

  def as_json(_ = {})
    @games.map do |game|
      GameRepresenter.new(game)
    end
  end
end
