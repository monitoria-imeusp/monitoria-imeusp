# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assistant_frequency do
    month 1
    presence false
    professor_id 1
    role_id 1
  end
end
