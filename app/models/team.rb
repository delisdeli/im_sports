class Team < ActiveRecord::Base
  belongs_to :division
  has_and_belongs_to_many :users
  has_many :invitations
  has_many :games
  attr_accessible :captain_email, :name, :division_id, :placeholder
end
