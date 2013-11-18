class Team < ActiveRecord::Base
  belongs_to :league
  has_and_belongs_to_many :users
  has_many :invitations
  attr_accessible :captain_email, :name, :league_id
end
