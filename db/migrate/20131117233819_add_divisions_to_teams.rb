class AddDivisionsToTeams < ActiveRecord::Migration
  def up
    remove_index :teams, :league_id
    remove_column :teams, :league_id
    t.references :division
    add_index :teams, :division_id, :unique => true
  end

  def down
    t.references :league
    add_index :teams, :league_id
    remove_index :teams, :division_id
    remove_column :teams, :division_id
  end
end
