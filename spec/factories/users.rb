# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id            "1"
    name          "User"
    email         "user@ime.usp.br"
    nusp          11111
    password      "password"
    confirmed_at  Time.now
    provider      "provider"
    uid           2
  end
  factory :another_user, class: User do
    id            "2"
    name          "Another"
    email         "another@ime.usp.br"
    nusp          22222
    password      "password"
    confirmed_at  Time.now
  end
end
