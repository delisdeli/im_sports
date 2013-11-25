class AddPlaceholderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :placeholder, :boolean
  end
end
