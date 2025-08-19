class Player < ApplicationRecord
  validates :public_id, uniqueness: true
end
