class AddNoteToNotifications < ActiveRecord::Migration
  def change
    add_column :messages, :note, :text
  end
end
