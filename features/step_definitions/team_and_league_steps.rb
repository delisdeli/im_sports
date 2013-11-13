Given /the following teams exist/ do |teams_table|
  teams_table.hashes.each do |team|
    Team.create!(team)
  end
end

Given /the following leagues exist/ do |leagues_table|
  leagues_table.hashes.each do |league|
    League.create!(league)
  end
end
