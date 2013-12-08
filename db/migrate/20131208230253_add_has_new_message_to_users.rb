class AddHasNewMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_new_message, :boolean
  end
end
