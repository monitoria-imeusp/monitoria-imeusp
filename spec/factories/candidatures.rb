# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :candidature do
    avaliability_daytime false
    avaliability_night_time false
    time_period_preference "MyString"
    course1_id 1
    course2_id 1
    course3_id 1
  end
end
