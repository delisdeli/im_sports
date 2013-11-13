# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    captain_email "MyString"
    name "MyString"
    league nil
  end
end
