# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    institute         "Instituto de Matemática e Estatística"
    gender            1
    rg                "1"
    cpf               "1"
    address           "Rua"
    complement        "Complemento"
    district          "Bairro"
    zipcode           "11111111"
    city              "Cidade"
    state             "Estado"
    tel               "0111111111"
    cel               "0111111111"
    has_bank_account  true
  end
end
