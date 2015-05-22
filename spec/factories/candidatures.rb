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

  factory :candidature1, class: Candidature do
  	daytime_availability false
  	nighttime_availability true
  	time_period_preference "Daytime"
  	course1_id 1
  	course2_id 2
  	course3_id 3
  	course4_id 4
  	semester_id 1
  end

  factory :candidature2, class: Candidature do
  	daytime_availability false
  	nighttime_availability true
  	time_period_preference "Daytime"
  	course1_id 1
  	course2_id 3
  	course3_id 2
  	course4_id 4
  	semester_id 1
  end

  factory :candidature3, class: Candidature do
  	daytime_availability false
  	nighttime_availability true
  	time_period_preference "Daytime"
  	course1_id 3
  	course2_id 1
  	course3_id 2
  	course4_id 4
  	semester_id 1
  end

  factory :candidature4, class: Candidature do
  	daytime_availability false
  	nighttime_availability true
  	time_period_preference "Daytime"
  	course1_id 4
  	course2_id 2
  	course3_id 1
  	course4_id 3
  	semester_id 1
  end


end
