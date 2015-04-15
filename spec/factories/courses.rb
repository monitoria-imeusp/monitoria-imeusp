# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course1, class: Course do
    name            "Introdução à Computação"
    course_code     "MAC0110"
    department_id   1
  end
  factory :course2, class: Course do
    name            "Estrutura de dados"
    course_code     "MAC0323"
    department_id   1
  end
  factory :course3, class: Course do
    name            "Algoritmos em Grafos"
    course_code     "MAC0328"
    department_id   1
  end
  factory :course4, class: Course do
    name            "Laboratório de programação eXtrema"
    course_code     "MAC0342"
    department_id   1
  end
end
