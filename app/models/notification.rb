class Notification < Message
  belongs_to :game
  belongs_to :user
  belongs_to :team
  attr_accessible :game, :user, :team, :note
  after_create :iterate_user_counter

  def iterate_user_counter
    if (self.user)
      self.user.iterate_notification_counter
    end
  end
end
