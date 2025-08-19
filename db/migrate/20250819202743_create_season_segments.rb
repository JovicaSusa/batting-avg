class CreateSeasonSegments < ActiveRecord::Migration[8.0]
  def change
    create_table :season_segments do |t|
      t.references :season, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :hits, null: false
      t.integer :at_bats, null: false
      t.integer :stint, null: false

      t.timestamps
    end
  end
end
