class Team < ActiveRecord::Base
  belongs_to :league
  has_many :users
  attr_accessible :captain_email, :name
end
