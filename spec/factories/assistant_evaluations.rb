# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assistant_evaluation do
    role_assistant_id 1
    ease_of_contact 1
    efficiency 1
    reliability 1
    overall 1
    comment "MyText"
  end
end
