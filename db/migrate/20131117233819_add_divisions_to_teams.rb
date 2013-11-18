class AddDivisionsToTeams < ActiveRecord::Migration
  def up
    remove_index :teams, :league_id
    remove_column :teams, :league_id
    add_column :teams, :division_id, :int
    add_index :teams, :division_id, :unique => true
  end

  def down
    add_column :teams, :league_id, :int
    add_index :teams, :league_id
    remove_index :teams, :division_id
    remove_column :teams, :division_id
  end
end
