Given /the following divisions exist/ do |divisions_table|
  divisions_table.hashes.each do |division|
    current_division = Division.create!(division)
    League.find_by_id(division[:league_id]).divisions << current_division
  end
end