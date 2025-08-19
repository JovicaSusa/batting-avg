class Team < ApplicationRecord
  validates :public_id, uniqueness: true
  validates :name, :public_id, presence: true
end
