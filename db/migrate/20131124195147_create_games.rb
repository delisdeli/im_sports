class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :division
      t.references :team1
      t.references :team2
      t.integer :score1
      t.integer :score2
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :status
      t.string :location

      t.timestamps
    end
    add_index :games, :division_id
    add_index :games, :team1_id
    add_index :games, :team2_id
  end
end
