Feature: Student register
    In order to register a student
    As a student
    I want to create a student account

    Scenario: Real student create a student account 
    	Given I'm at the home page
        When I click the "Novo Aluno" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "NºUSP" field with "012345"
        And I select the gender option "Masculino"
        And I fill the "RG" field with "123"
        And I fill the "CPF" field with "321"
        And I fill the "Endereço" field with "R. Matao"
        And I fill the "Complemento" field with ""
        And I fill the "Bairro" field with "Butanta"
        And I fill the "CEP" field with "000"
        And I fill the "Cidade" field with "Sao Paulo"
        And I fill the "Estado" field with "Sao Paulo"
        And I fill the "Telefone residencial" field with "0123456789"
        And I fill the "Telefone celular" field with "0123456789"
        And I fill the "Endereço eletrônico" field with "eu@usp.br"
        And I select the count option "Sim"
        And I press the "Cadastrar" button
        Then I should see "Nome: Carlinhos"
        And I should see "Sexo: Masculino"
    
    Scenario: Real student can't create a student account
        Given I'm at the home page
        When I click the "Novo Aluno" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "NºUSP" field with "01245"
        And I select the gender option "Masculino"
        And I fill the "RG" field with "123"
        And I fill the "CPF" field with "321"
        And I fill the "Endereço" field with "R. Matao"
        And I fill the "Complemento" field with ""
        And I fill the "Bairro" field with "Butanta"
        And I fill the "CEP" field with "000"
        And I fill the "Cidade" field with "Sao Paulo"
        And I fill the "Estado" field with "Sao Paulo"
        And I fill the "Telefone residencial" field with "012346789"
        And I fill the "Telefone celular" field with "012456789"
        And I fill the "Endereço eletrônico" field with "eu@usp.br"
        And I select the count option "Sim"
        And I press the "Cadastrar" button
        Then I should not see "Nome: Carlinhos"
        And I should not see "Sexo: Masculino"
