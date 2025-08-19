class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :public_id, null: false
      t.string :name, null: false
      t.integer :year, null: false

      t.timestamps
    end

    add_index :teams, [ :public_id, :year ]
  end
end
