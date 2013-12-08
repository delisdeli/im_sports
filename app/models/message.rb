class Message < ActiveRecord::Base
  belongs_to :team_id
  belongs_to :user_id
  belongs_to :game_id
  attr_accessible :type
end
