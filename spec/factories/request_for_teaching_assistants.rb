# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request_for_teaching_assistant do
    professor_id 1
    subject "MyString"
    requestedNumber 1
    priority 1
    student_assistance false
    work_correction false
    test_oversight false
  end
end
