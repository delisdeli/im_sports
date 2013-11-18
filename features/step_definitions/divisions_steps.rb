Given /the following divisions exist/ do |divisions_table|
  divisions_table.hashes.each do |division|
    year = division.delete("year").to_i
    month = division.delete("month").to_i
    day = division.delete("day").to_i
    date = Date.new(year, month, day)
    division[:start_date] = date
    current_division = Division.create!(division)
    League.find_by_id(division[:league_id]).divisions << current_division
  end
end
