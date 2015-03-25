Feature: Student register
    In order to register a student
    As a student
    I want to create a student account

    Scenario: Real student create a student account
    	Given I'm at the home page
        And I'm ready to receive email
        When I click the "Cadastrar-se" link
        And I fill the fields for student "Carlinhos" with nusp "012345" and email "cef@gmail.com"
        And I press the "Salvar" button
        And I confirm the user account with email "cef@gmail.com"
        And I should see "Acessar"
        And I fill the "Número USP" field with "012345"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        Then I should see "Acesso efetuado com sucesso."

    Scenario: Real student create a student account after asking for reconfirmation email
        Given I'm at the home page
        And I'm ready to receive email
        When I click the "Cadastrar-se" link
        And I fill the fields for student "Little Charles" with nusp "123456" and email "cef@hotmail.com"
        And I press the "Salvar" button
        And I click the "Acessar" link
        And I click the "Não recebeu o email de confirmação?" link
        And I fill the "E-mail" field with "cef@hotmail.com"
        And I press the "Reenviar email de confirmação de criação de conta" button
        And I confirm the user account with email "cef@hotmail.com"
        And I click the "Cadastrar-se" link
        And I click the "Acessar" link
        And I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        Then I should see "Acesso efetuado com sucesso."


    Scenario: Real student can't create a student account
        Given I'm at the home page
        When I click the "Cadastrar-se" link
        And I fill the fields for student "Carlinhos" with nusp "01245" and email "cef@gmail.com"
        And I press the "Salvar" button
        Then I should not see "Nome: Carlinhos"
        And I should not see "Sexo: Masculino"

    Scenario: Student cannot create account with same NUSP
        Given I'm at the home page
        And there is a student with name "Carlinhos" with nusp "012345" and email "cef@ime.usp.br"
        When I click the "Cadastrar-se" link
        And I fill the fields for student "Carlinhos" with nusp "012345" and email "cef@gmail.com"
        And I press the "Salvar" button
        Then I should see "Número USP já está em uso"

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
