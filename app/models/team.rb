class Team < ActiveRecord::Base
  belongs_to :division
  has_and_belongs_to_many :users
  has_many :invitations
  attr_accessible :captain_email, :name, :division_id, :placeholder

  def fake?
    return self.placeholder
  end

  def Team.get_fake_by_name(name)
    fake_team = Team.find_by_name(name)
    unless fake_team and fake_team.fake?
      fake_team = Team.create(:name=>name, :placeholder=>true)
    end
    return fake_team
  end
end
