class HomeController < ApplicationController
  def index
    result = Season.includes(:player, season_segments: :team)

    if params.dig(:q, :player_id).present?
      result = result.joins(:player).where(players: { public_id: params[:q][:player_id] })
    end

    if params.dig(:q, :year).present?
      result = result.where(year: params[:q][:year])
    end

    @pagy, @seasons = pagy(result)
  end
end
