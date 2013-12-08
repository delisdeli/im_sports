# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    team_id nil
    user_id nil
    game_id nil
    type ""
  end
end
