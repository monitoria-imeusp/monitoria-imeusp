# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    password "MyString"
    nusp "MyString"
    gender 1
    rg "MyString"
    cpf "MyString"
    adress "MyString"
    complement "MyString"
    district "MyString"
    zipcode "MyString"
    city "MyString"
    state "MyString"
    tel "MyString"
    cel "MyString"
    email "MyString"
    has_bank_account false
  end
end
