# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course1, class: Course do
    name            "Introdução à Computação"
    course_code     "MAC0110"
    department_id   1
  end
end
