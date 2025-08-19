class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :public_id, null: false, index: { unique: true }
      t.string :name, null: false

      t.timestamps
    end
  end
end
