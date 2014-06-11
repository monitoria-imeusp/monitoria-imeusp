# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    password "MyString"
    nusp "111111111"
    gender 1
    rg "MyString"
    cpf "MyString"
    adress "MyString"
    complement "MyString"
    district "MyString"
    zipcode "MyString"
    city "MyString"
    state "MyString"
    tel "0111111111"
    cel "0111111111"
    email "email@email.com"
    has_bank_account false
  end
end
