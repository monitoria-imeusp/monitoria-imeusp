# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :candidature do
    daytime_availability false
    nighttime_availability false
    time_period_preference "MyString"
    course1_id 1
    course2_id 1
    course3_id 1
    course4_id 1
  end
end
