# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :secretary do
    nusp "1234999"
    name "Secretaria"
    email "secretaria@ime.usp.br"
    password "12345678"
    confirmed_at Time.now
  end
end
