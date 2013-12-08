class AddHasNewNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_new_notification, :boolean
  end
end
