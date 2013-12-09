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

  def self.determine_gameday(some_weeks_games)
    some_weeks_games[0].date
  end

  def this_weeks_gameday
    next_gameday(Date.today)
  end

  def prev_gameday(gameday)
    closest_game_date(gameday, 1, -1)
  end

  def next_gameday(gameday)
    closest_game_date(gameday, 1)
  end

  def closest_game_date(gameday, inclusive_factor=0, before_after_factor=1)
    smallest_diff = 20.years
    closest_date = nil
    self.games.each do |game|
      time_difference = (game.date - gameday).to_i * before_after_factor
      if (0 + inclusive_factor) < time_difference and time_difference < smallest_diff
        smallest_diff = time_difference
        closest_date = game.date
        p closest_date
      end
    end
    closest_date = self.last_game_day unless closest_date
    closest_date
  end

  def get_weeks_games(gameday)
    Game.where(division_id: self.id, date: gameday)
  end

  def last_game_day
    self.games.map {|game| game.date}.max
    # for self.games.each do |game|
    #   if latest_date.nil? or game.date > lastest_date
    #     latest_date = game.date
    #   end
    # end
    # latest_date
  end

  def get_games_by_team(team)
    team_games = Array.new
    self.games.each do |game|
      if game.team1_id == team.id or game.team2_id == team.id
        team_games << game
      end
    end
    team_games
  end

  def replace_fake_team(team)
    #iterate over games and replace all instances of placeholder team X with team
    x = self.real_teams.count
    fake_team = Team.get_fake_by_name("Placeholder Team #{x}")
    self.games.each do |game|
        if game.team1 == fake_team
            game.team1 = team
            game.save
        elsif game.team2 == fake_team
            game.team2 = team
            game.save
        end
    end
  end

  def restore_fake_team(team)
    #Iterate over games and replace all instances of team with placeholder team X
    x = self.real_teams.count
    fake_team = Team.get_fake_by_name("Placeholder Team #{x}")
    self.games.each do |game|
        if game.team1 == team
            game.team1 = fake_team
            game.save
        elsif game.team2 == team
            game.team2 = fake_team
            game.save
        end
    end
  end

  def replace_fake_location(location)
    #Iterate over games and replace all instances of location X with location
    x = self.locations.count
    fake_loc = Location.get_by_name("Placeholder Location #{x}")
    self.games.each do |game|
        if game.location == fake_loc.name
            game.location = location.name
            game.save
        end
    end
  end

  def restore_fake_location(location)
    #Iterate over games and replace all instances of location with location X
    x = self.locations.count
    self.games.each do |game|
        if game.location == location.name
            game.location = "Placeholder Location #{x}"
            game.save
        end
    end
  end

  def real_teams
    return self.teams.where(:placeholder=>false)
  end

  def fake_teams
    return self.teams.where(:placeholder=>true)
  end

  def first_unplayed_team(first_team, team_queue, played_teams)
    team_queue.each do |team|
      (return team) unless played_teams[first_team.id].include? team.id
    end
    nil
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

  def generate_schedule
    self.teams = (1..self.num_teams).map {|x| Team.get_fake_by_name("Placeholder Team #{x}")}
    game_dates = (0..(num_weeks-1)).map {|week_num| start_date.advance(weeks: week_num)}
    time_slots = self.gen_time_slots
    team_queue = self.teams.map {|team| team}
    played_teams = {}
    self.teams.each {|team| played_teams[team.id] = [team.id]}
    game_dates.each do |game_date|
      time_slots.each do |time_slot|
        self.num_locations.times do |i|
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
                                      end_time: time_slot + self.game_length.minutes,
                                      location: "Placeholder Location #{i+1}",
                                      date: game_date )
        end
      end
    end
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

  def print_time_slot
    self.print_start_time + " - " + self.print_end_time
  end

  # def fits_schedule
  # 	errors.add("not enough locations to accomodate division schedule") unless
  # 		((self.end_time - self.start_time) / game_length / num_locations) <= num_teams
  # end
end
