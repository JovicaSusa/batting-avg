class SeasonSegment < ApplicationRecord
  belongs_to :season
  belongs_to :team

  validates :at_bats, :hits, :stint, presence: true
end
