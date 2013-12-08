class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.references :team
      t.references :user
      t.references :game
      t.string :type

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :type

    drop_table :invitations
  end

  def down
    create_table :invitations do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
    add_index :invitations, :team_id
    add_index :invitations, :user_id
    
    drop_table :messages
  end
end
