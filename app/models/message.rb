class Message < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  belongs_to :game
  attr_accessible :type
  after_save :user_has_new_message

  def user_has_new_message
    if (self.user)
      user.has_new_message = true
      user.save
    end
  end

end
