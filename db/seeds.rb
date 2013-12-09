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

#Game.create(date: 'Dec 20, 2013', end_time:'07:00 PM', location:'Hearst Gym', score1:0, score2:0, start_time:'06:00 PM', status:'pending', division_id:1, team1_id:1, team2_id:2)
#Division.create(end_time:'08:00 PM', game_length:2, name:'division', num_teams:4, start_time:'06:00 PM', num_locations:1, league_id:1, start_date:'Dec 08, 2013', num_weeks:2)
#Team.create(captain_email:'dennis@gmail.com', name:'Wildcats', division_id:1, placeholder:'placeholder')
#Team.create(captain_email:'francis@gmail.com', name:'Bears', division_id:1, placeholder:'placeholder')
#User.create(name:'Dennis', email:'dennis@gmail.com', password:'123', password_confirmation:'123', remember_token:1)
#User.create(name:'Francis', email:'francis@gmail.com', password:'123', password_confirmation:'123', remember_token:1)

