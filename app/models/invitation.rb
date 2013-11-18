class Invitation < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  attr_accessible :team, :user
end
