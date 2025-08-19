require "csv"

class ImportsController < ApplicationController
  def create
    file_to_import = params[:csv_file]

    if file_to_import.present?
      CSV.foreach(file_to_import, headers: true) do |row|
        ApplicationRecord.transaction do
          hits = row["H"].to_i
          year = row["yearID"]
          stint = row["stint"]
          team_id = row["teamID"]
          at_bats = row["AB"].to_i
          player_id = row["playerID"]

          player = Player.find_or_create_by!(public_id: player_id)
          season = player.seasons.find_or_initialize_by(year: year)
          team = Team.find_by!(year: year, public_id: team_id)
          season.update!(
            at_bats: season.at_bats.to_i + at_bats,
            hits: season.hits.to_i + hits
          )
          season.season_segments.create!(
            hits: hits,
            stint: stint,
            at_bats: at_bats,
            team:
          )
        end
      end
    end
  end
end
