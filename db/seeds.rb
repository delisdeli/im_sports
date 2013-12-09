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

Team.create(captain_email:'dennis@berkeley.edu', name:'Wildcats', division_id:1, placeholder:false)
Team.create(captain_email:'francis@berkeley.edu', name:'Bears', division_id:2, placeholder:false)
Team.create(captain_email:'andrew@berkeley.edu', name:'Wolves', division_id:3, placeholder:false)
Team.create(captain_email:'diana@berkeley.edu', name:'Baby Bears', division_id:4, placeholder:false)
Team.create(captain_email:'daphne@berkeley.edu', name:'Alpha Beta Gamma', division_id:5, placeholder:false)
Team.create(captain_email:'yuuki@berkeley.edu', name:'Giraffes', division_id:6, placeholder:false)
Team.create(captain_email:'daniel@berkeley.edu', name:'AAA', division_id:7, placeholder:false)
Team.create(captain_email:'sam@berkeley.edu', name:'Theta Tau', division_id:8, placeholder:false)
Team.create(captain_email:'anni@berkeley.edu', name:'Cal Bears', division_id:1, placeholder:false)

User.create(name:'Dennis', email:'dennis@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Francis', email:'francis@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Daphne', email:'daphne@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Diana', email:'diana@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Andrew', email:'Andrew@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Yuuki', email:'Yuuki@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Sam', email:'Sam@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)
User.create(name:'Anni', email:'Anni@berkeley.edu', password:'123456', password_confirmation:'123456', remember_token:1)

