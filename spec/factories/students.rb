# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    id                1
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

  factory :student2, class: Student do
    id                2
    institute         "Instituto de Matemática e Estatística"
    gender            1
    rg                "2"
    cpf               "2"
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

  factory :student3, class: Student do
    id                3
    institute         "Instituto de Matemática e Estatística"
    gender            1
    rg                "3"
    cpf               "3"
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

  factory :student4, class: Student do
    id                4
    institute         "Instituto de Matemática e Estatística"
    gender            1
    rg                "4"
    cpf               "4"
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
