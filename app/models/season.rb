class Season < ApplicationRecord
  belongs_to :player

  validates :year, :hits, :at_bats, :batting_avg, presence: true
end
