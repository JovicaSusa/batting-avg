class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :public_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
