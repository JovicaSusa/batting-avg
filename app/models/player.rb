class Player < ApplicationRecord
  validates :public_id, uniqueness: true

  has_many :seasons, dependent: :destroy
  has_many :season_segments, through: :seasons
end
