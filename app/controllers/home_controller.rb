class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @seasons = pagy(Season.includes(:player, season_segments: :team))
  end
end
