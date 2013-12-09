class Message < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  belongs_to :game
  attr_accessible :type, :team, :user, :game
  after_save :user_has_new_message
  after_create :iterate_user_counter

  def user_has_new_message
    if (self.user)
      user.has_new_message = true
      user.save
    end
  end

  def iterate_user_counter
    if (self.user)
      self.user.iterate_notification_counter
    end
  end
end
