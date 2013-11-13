class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
    add_index :invitations, :team_id
    add_index :invitations, :user_id
  end
end
