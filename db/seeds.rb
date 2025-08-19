require 'csv'

CSV.foreach(Rails.root.join('db', 'seeds', 'teams.csv'), headers: true) do |row|
  Team.create!(year: row['yearID'], public_id: row['teamID'], name: row['name'])
end
