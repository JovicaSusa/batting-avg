class HomeController < ApplicationController
  def index
    @seasons = Season.includes(:player, season_segments: :team).limit(10)
  end
end
