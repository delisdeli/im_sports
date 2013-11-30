class ChangeGameLengthToIntDivisions < ActiveRecord::Migration
  def up
    remove_column :divisions, :game_length
    add_column :divisions, :game_length, :int
  end

  def down
    remove_column :divisions, :game_length
    add_column :divisions, :game_length, :string
  end
end
