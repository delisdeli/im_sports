class Game < ActiveRecord::Base
  belongs_to :division
  belongs_to :team1, class_name => 'Team'
  belongs_to :team2, class_name => 'Team'
  attr_accessible :date, :end_time, :location, :score1, :score2, :start_time, :status

  def get_status
    return case self.status
      when 1 then "Scheduled"
      when 2 then "Finished"
      when 3 then "TBD"
      #add extra statuses here
      else "Unknown"
    end
  end
end
