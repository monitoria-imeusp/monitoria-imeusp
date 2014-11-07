# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assistant_role do
    student_id                        1
    request_for_teaching_assistant_id 1
  end
end
