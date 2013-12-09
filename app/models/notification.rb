class Notification < Message
  belongs_to :game
  belongs_to :user
  belongs_to :team
  attr_accessible :game, :user, :team

end
