class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :games, :teams

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def games
    @games ||= Game.all
  end

  def teams
    @teams ||= Team.all
  end
end
