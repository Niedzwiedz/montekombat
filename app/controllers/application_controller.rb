class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :users, :games, :teams, :current_user, :logged_in?
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def render_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def games
    @games ||= Game.all
  end

  def teams
    @teams ||= Team.all
  end

  def users
    @users ||= User.all
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def ensure_logged_in
    return if logged_in?
    flash[:danger] = "Please log in."
    redirect_to login_path
  end
end
