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

  def get_games_by_team(team)
    team_games = Array.new
    self.games.each do |game|
      if game.team1 == team or game.team2 == team
        team_games << game
      end
    end
    team_games
  end

  def generate_schedule
    for i in 0...self.num_teams
       teamname = "team" + (i+1).to_s
       fake_team = Team.create!(:name => teamname, :placeholder => true)
       self.teams << fake_team
    end
    for i in 0...self.teams.length
      for j in i+1...self.teams.length
        test_game = Game.create!
        test_game.team1_id = self.teams.at(i).id
        test_game.team2_id = self.teams.at(j).id
        test_game.division_id = self.id
        newDate = "2013-03-06"
        newStartTime = "6:00"
        newEndTime = "8:00"
        newScore1 = "0"
        newScore2 = "0"
        test_game.score1 = newScore1
        test_game.score2 = newScore2
	test_game.start_time = newStartTime
        test_game.end_time = newEndTime
        test_game.date = newDate
        self.games << test_game
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

  # def fits_schedule
  # 	errors.add("not enough locations to accomodate division schedule") unless
  # 		((self.end_time - self.start_time) / game_length / num_locations) <= num_teams
  # end
end
