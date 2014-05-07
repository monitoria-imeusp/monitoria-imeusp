# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email 'admin@admin.com'
    password 'password'
  end
end
