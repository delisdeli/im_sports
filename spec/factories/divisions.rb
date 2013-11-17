# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :division do
    league nil
    name "MyString"
    num_teams ""
    start_time "2013-11-16 23:59:41"
    end_time "2013-11-16 23:59:41"
    game_length "2013-11-16 23:59:41"
    num_locations ""
  end
end
