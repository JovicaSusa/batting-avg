class Season < ApplicationRecord
  belongs_to :player
  has_many :season_segments, dependent: :destroy

  validates :year, :hits, :at_bats, :batting_avg, presence: true

  before_validation :calculate_batting_avg

  private

  def calculate_batting_avg
    self.batting_avg = at_bats.zero? ? 0 : hits / at_bats.to_f
  end
end
