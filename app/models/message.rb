class Message < ActiveRecord::Base
  belongs_to :team_id
  belongs_to :user_id
  belongs_to :game_id
  attr_accessible :type
  after_save :user_has_new_message

  def user_has_new_message
    if (self.user)
      user.has_new_message = true
      user.save
    end
  end

end
