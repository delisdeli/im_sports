class Game < ActiveRecord::Base
  belongs_to :division
  belongs_to :team1, :class_name => 'Team', :foreign_key => "team1_id"
  belongs_to :team2, :class_name => 'Team', :foreign_key => "team2_id"
  attr_accessible :date, :end_time, :location, :score1, :score2, :start_time, :status, :division_id, :team1_id, :team2_id

  after_save notify_user

  def get_status
    return case self.status
      when 1 then "Scheduled"
      when 2 then "Finished"
      when 3 then "TBD"
      #add extra statuses here
      else "Unknown"
    end
  end

  def self.status_options
    return {"Scheduled"=>1, "Finished"=>2, "TBD"=>3}
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
    team1.users.each do |user|
      Notification.create(:game=>self, :team=>team1, :user=>user)
    end
    team2.users.each do |user|
      Notification.create(:game=>self, :team=>team2, :user=>user)
    end
  end
end
