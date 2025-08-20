class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.integer :year, null: false
      t.references :player, null: false, foreign_key: true
      t.decimal :batting_avg, null: false, precision: 5, scale: 3
      t.integer :at_bats, null: false
      t.integer :hits, null: false

      t.timestamps
    end
  end
end
