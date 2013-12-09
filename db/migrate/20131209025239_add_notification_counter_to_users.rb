class AddNotificationCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_counter, :integer
  end
end
