class GameRepresenter
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def as_json(_ = {})
    {
      id: game.id,
      name: game.name,
    }
  end
end
