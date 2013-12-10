class Game < ActiveRecord::Base
  belongs_to :division
  belongs_to :team1, :class_name => 'Team', :foreign_key => "team1_id"
  belongs_to :team2, :class_name => 'Team', :foreign_key => "team2_id"
  attr_accessible :date, :end_time, :location, :score1, :score2, :start_time, :status, :division_id, :team1_id, :team2_id

  after_save :notify_user

  def get_status
    return case self.status
      when 1 then "Scheduled"
      when 2 then "Finished"
      when 3 then "TBD"
      when 4 then "Canceled"
      #add extra statuses here
      else "Unknown"
    end
  end

  def self.status_options
    return {"Scheduled"=>1, "Finished"=>2, "TBD"=>3, "Canceled"=>4}
  end

  def print_start_time
    self.start_time.strftime("%I:%M %p")
  end
  def print_end_time
    self.end_time.strftime("%I:%M %p")
  end

  def print_date
    self.date.strftime("%B %e, %Y")
  end

  def notify_user
    [team1, team2].each do |team|
      team.users.each do |user|
        user.notifications << Notification.create('game' => self, 'team' => team, 'user' => user)
      end
    end
  end

  def game_status
    if score1 and score2 and (score1 > 0 or score2 > 0)
      return post_game_info
    end
    return pre_game_info
  end

  def pre_game_info
    "#{self.location} @ #{self.print_start_time}"
  end

  def post_game_info
    "#{self.score1} - #{self.score2}"
  end

  def opponent(team)
    if self.team1 == team
      return self.team2
    end
    self.team1
  end
end
