class ImportBattingStats
  attr_reader :file
  private :file

  VALID_HEADERS = [
    HITS = "H",
    YEAR = "yearID",
    STINT = "stint",
    TEAM_ID = "teamID",
    AT_BATS = "AB",
    PLAYER_ID = "playerID"
  ].freeze

  def initialize(file)
    @file = file
    @processed_count = 0
  end

  def call
    broadcast_import_start

    CSV.foreach(file, headers: true) do |row|
      ApplicationRecord.transaction do
        hits = row[HITS].to_i
        year = row[YEAR]
        stint = row[STINT]
        team_id = row[TEAM_ID]
        at_bats = row[AT_BATS].to_i
        player_id = row[PLAYER_ID]

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

      @processed_count += 1

      broadcast_import_status
    end
  end

  private

  def broadcast_import_start
    Turbo::StreamsChannel.broadcast_update_to(
      "imports",
      target: "seasons",
      partial: "shared/spinner"
    )
  end

  def broadcast_import_status
    return unless (@processed_count % 1000).zero?

    Turbo::StreamsChannel.broadcast_update_to(
      "imports",
      target: "import-progress",
      html: @processed_count
    )
  end
end
