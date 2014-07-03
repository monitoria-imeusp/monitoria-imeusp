Feature: Student register
    In order to register a student
    As a student
    I want to create a student account

    Scenario: Real student create a student account
    	Given I'm at the home page
        And I'm ready to receive email
        When I click the "Cadastrar-se" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "Confirme a senha" field with "12345678"
        And I fill the "Número USP" field with "012345"
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
        And I fill the "Celular" field with "0123456789"
        And I fill the "Email" field with "eu@usp.br"
        And I select the count option "Sim"
        And I press the "Salvar" button
        And I confirm the student account with email "eu@usp.br"
        And I should see "Acessar"
        And I fill the "Número USP" field with "012345"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Acesso efetuado com sucesso."


    Scenario: Real student can't create a student account
        Given I'm at the home page
        When I click the "Cadastrar-se" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "Confirme a senha" field with "12345678"
        And I fill the "Número USP" field with "01245"
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
        And I fill the "Celular" field with "012456789"
        And I fill the "Email" field with "eu@usp.br"
        And I select the count option "Sim"
        And I press the "Salvar" button
        Then I should not see "Nome: Carlinhos"
        And I should not see "Sexo: Masculino"

    Scenario: Admin cannot create a student account while logged
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        Then I should not see "Cadastrar-se"

    Scenario: Professor cannot create a student account while logged
        Given I'm at the professor login page
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should not see "Cadastrar-se"

    Scenario: Secretary cannot create a student account while logged
        Given I'm at the secretary login page
        And there is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should not see "Cadastrar-se"
