# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor do
    email         'professor@professor.com'
    password      'password'
    nusp          '1234567'
    department_id 1
    confirmed_at  Time.now
  end
  factory :super_professor, class: Professor do
    email           'prof@ime.usp.br'
    password        'password'
    nusp            '1234567'
    department_id   1
    professor_rank  2
    confirmed_at    Time.now
  end
end
