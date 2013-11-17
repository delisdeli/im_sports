class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.references :league
      t.string :name
      t.integer :num_teams
      t.time :start_time
      t.time :end_time
      t.string :game_length
      t.integer :num_locations

      t.timestamps
    end
    add_index :divisions, :league_id
  end
end
