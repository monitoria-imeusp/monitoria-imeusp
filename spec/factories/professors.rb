# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor do
    email 'professor@professor.com'
    password 'password'
  end
end
