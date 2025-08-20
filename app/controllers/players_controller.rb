class PlayersController < ApplicationController
  def index
    result = Player

    if params[:q].present?
      result = Player.where("public_id ILIKE ?", "%#{Player.sanitize_sql_like(params[:q])}%")
    end

    @pagy, @players = pagy(result)
    combobox_display = @players.map { |p| [ p.public_id, p.public_id ] }

    render turbo_stream: helpers.async_combobox_options(combobox_display, next_page: @pagy.next)
  end
end
