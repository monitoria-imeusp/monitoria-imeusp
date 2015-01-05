# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor do
    id            1
    department_id 1
  end
  factory :super_professor, class: Professor do
    id              2
    department_id   1
    professor_rank  1
  end
  factory :hiper_professor, class: Professor do
    id              3
    department_id   1
    professor_rank  2
  end
end
