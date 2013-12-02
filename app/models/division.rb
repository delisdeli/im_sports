class Division < ActiveRecord::Base
  belongs_to :league
  after_create :generate_schedule
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
  has_many :games
  has_and_belongs_to_many :locations

  def get_games_by_team(team)
    team_games = Array.new
    self.games.each do |game|
      if game.team1_id == team.id or game.team2_id == team.id
        team_games << game
      end
    end
    team_games
  end

  def first_unplayed_team(first_team, team_queue, played_teams)
    team_queue.each do |team|
      (return team) unless played_teams[first_team.id].include? team.id
    end
    nil
  end

  def generate_schedule
    self.teams = (1..self.num_teams).map {|x| Team.get_fake_by_name("team#{x}")}
    game_dates = (0..(num_weeks-1)).map {|week_num| start_date.advance(weeks: week_num)}
    time_slots = self.gen_time_slots
    team_queue = self.teams.map {|team| team}
    played_teams = {}
    self.teams.each {|team| played_teams[team.id] = [team.id]}
    game_dates.each do |game_date|
      time_slots.each do |time_slot|
        self.num_locations.times do 
         self.locations.each do |location|
          team1 = team_queue[0]
          team_queue << team_queue.delete_at(0)
          team2 = first_unplayed_team(team1, team_queue, played_teams)
          played_teams[team1.id] << team2.id
          played_teams[team2.id] << team1.id
          self.games << Game.create!( team1_id: team1.id,
                                      team2_id: team2.id,
                                      division_id: self.id,
                                      status: 1,
                                      start_time: time_slot,
                                      end_time: time_slot + self.game_length.to_i.minutes,
                                      location: "location",
                                      date: game_date )
        end
      end
    end
  end

  def gen_time_slots
    game_time = self.start_time
    game_times = []
    while game_time < end_time
      game_times << game_time
      game_time += self.game_length.to_i.minutes
    end
    game_times
  end

  def start_before_end_time
    errors.add(:start_time, "must be before end time") unless
       self.start_time < self.end_time
  end 

  def print_start_time
    self.start_time.strftime("%I:%M %p")
  end

  def print_end_time
    self.end_time.strftime("%I:%M %p")
  end
  
  def print_start_date
    self.start_date.strftime("%B %e, %Y")
  end

  # def fits_schedule
  # 	errors.add("not enough locations to accomodate division schedule") unless
  # 		((self.end_time - self.start_time) / game_length / num_locations) <= num_teams
  # end
end
