class Team < ApplicationRecord
  validates :public_id, uniqueness: { scope: :year, message: "Only one team id is allowed per year" }
  validates :name, :year, :public_id, presence: true
end
