# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


League.create(name: 'Frat', sport:'basketball')
League.create(name: 'Recreational', sport:'basketball')
League.create(name: '3on3', sport:'football')
League.create(name: 'Frat', sport:'football')
League.create(name:'3on3', sport:'volleyball')
League.create(name:'Frat', sport:'volleyball')
League.create(name:'Recreational', sport:'volleyball')
League.create(name:'Open', sport:'basketball')



Division.create(end_time:'8PM', game_length:60, name:'Division 1', num_teams:8, start_time:'6PM', num_locations:2, league_id:1, start_date:Date.new(2013, 8, 20), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 2', num_teams:8, start_time:'6PM', num_locations:2, league_id:2, start_date:Date.new(2013, 8, 22), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 3', num_teams:8, start_time:'6PM', num_locations:2, league_id:3, start_date:Date.new(2013, 8, 21), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 4', num_teams:8, start_time:'6PM', num_locations:2, league_id:4, start_date:Date.new(2013, 8, 24), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 5', num_teams:8, start_time:'6PM', num_locations:2, league_id:5, start_date:Date.new(2013, 8, 27), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 6', num_teams:8, start_time:'6PM', num_locations:2, league_id:6, start_date:Date.new(2013, 8, 28), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 7', num_teams:8, start_time:'6PM', num_locations:2, league_id:7, start_date:Date.new(2013, 8, 29), num_weeks:7)
Division.create(end_time:'8PM', game_length:60, name:'Division 8', num_teams:8, start_time:'6PM', num_locations:2, league_id:8, start_date:Date.new(2013, 8, 23), num_weeks:7)

team1 = Team.create(captain_email:'dennis@berkeley.edu', name:'Wildcats', division_id:1, placeholder:false)
team2 = Team.create(captain_email:'francis@berkeley.edu', name:'Bears', division_id:2, placeholder:false)
team3 = Team.create(captain_email:'andrew@berkeley.edu', name:'Wolves', division_id:3, placeholder:false)
team4 = Team.create(captain_email:'diana@berkeley.edu', name:'Baby Bears', division_id:4, placeholder:false)
team5 = Team.create(captain_email:'daphne@berkeley.edu', name:'Alpha Beta Gamma', division_id:5, placeholder:false)
team6 = Team.create(captain_email:'yuuki@berkeley.edu', name:'Giraffes', division_id:6, placeholder:false)
team7 = Team.create(captain_email:'daniel@berkeley.edu', name:'AAA', division_id:7, placeholder:false)
team8 = Team.create(captain_email:'sam@berkeley.edu', name:'Theta Tau', division_id:8, placeholder:false)
team9 = Team.create(captain_email:'anni@berkeley.edu', name:'Cal Bears', division_id:1, placeholder:false)

user1 = User.create(name:'Dennis', email:'dennis@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user2 = User.create(name:'Francis', email:'francis@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user3 = User.create(name:'Andrew', email:'andrew@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user4 = User.create(name:'Daphne', email:'daphne@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user5 = User.create(name:'Diana', email:'diana@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user6 = User.create(name:'Yuuki', email:'yuuki@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user7 = User.create(name:'Daniel', email:'daniel@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user8 = User.create(name:'Sam', email:'sam@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
user9 = User.create(name:'Anni', email:'anni@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)

team1.users << user1
team2.users << user2
team3.users << user3
team4.users << user4
team5.users << user5
team6.users << user6
team7.users << user7
team8.users << user8
team9.users << user9
team1.save
team2.save
team3.save
team4.save
team5.save
team6.save
team7.save
team8.save
team9.save
