# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

League.create!(name: 'league1', sport: 'basketball')
League.create!(name: 'league2', sport: 'basketball')

curr_user = User.create!(name: 'admin', email: 'email@email.com', password: 'password', password_confirmation: 'password')
curr_user.admin = true
curr_user.save

curr_user = User.create!(name: 'user1', email: 'email2@email.com', password: 'password', password_confirmation: 'password')
curr_user.admin = false
curr_user.save

curr_user = User.create!(name: 'user2', email: 'email3@email.com', password: 'password', password_confirmation: 'password')
curr_user.admin = false
curr_user.save

current_division = Division.create!(name: 'testdiv', num_teams: '8', start_time: '8pm', end_time: '10pm', num_locations: '2', num_weeks: '2', game_length: '60', league_id: '1', start_date: Date.new(('2013').to_i, ('11').to_i, ('18').to_i))

League.find_by_id('1').divisions << current_division

current_team = Team.create!(captain_email: 'email@email.com', name: 'teamawesome', division_id: '1')
Division.find_by_id('1').teams << current_team
