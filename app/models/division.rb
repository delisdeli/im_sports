class Division < ActiveRecord::Base
  belongs_to :league
  attr_accessible :end_time, :game_length, :name, :num_teams, :start_time, :num_locations, :league_id, :start_date, :num_weeks
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :game_length, presence: true
  validates :num_teams, presence: true
  validates :num_locations, presence: true
  validates :num_weeks, presence: true
  validates :start_date, presence: true
  validate :start_before_end_time
  # validate :fits_schedule

  has_many :teams

  def start_before_end_time
    errors.add(:start_time, "must be before end time") unless
       self.start_time < self.end_time
  end 

  # def fits_schedule
  # 	errors.add("not enough locations to accomodate division schedule") unless
  # 		((self.end_time - self.start_time) / game_length / num_locations) <= num_teams
  # end
end
