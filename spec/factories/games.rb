# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    division nil
    team1 nil
    team2 nil
    score1 ""
    score2 ""
    date "2013-11-24"
    start_time "2013-11-24 11:51:47"
    end_time "2013-11-24 11:51:47"
    status ""
    location "MyString"
  end
end
