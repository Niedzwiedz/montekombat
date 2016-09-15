class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_four_o_four

  def render_four_o_four
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
