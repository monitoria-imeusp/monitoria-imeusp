# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :semester do
    id                1
    year              2014
    parity            1
    open              true
    active            true
    frequency_period  0
    evaluation_period false
  end
end
