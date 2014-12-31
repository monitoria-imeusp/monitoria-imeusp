# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id            "1"
    name          "User"
    email         "user@ime.usp.br"
    nusp          11111
    password      "password"
    confirmed_at  Time.now
  end
  factory :another_user, class: User do
    id            "2"
    name          "Student"
    email         "student@ime.usp.br"
    nusp          22222
    password      "password"
    confirmed_at  Time.now
  end
end
