Feature: Secretary creation
    In order to create a secretary
    As an admin
    I want to create a secretary

    Scenario: Admin creating a secretary
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And I'm ready to receive email
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Cadastrar funcionário" link
        And I fill the "Número USP" field with "1234567"
        And I fill the "Nome" field with "Marcia"
        And I fill the "Email" field with "marcia@ime.usp.br"
        And I press the "Enviar" button
        And I click the "Sair" link
        And I confirm the secretary account with email "marcia@ime.usp.br" and sign in
        Then I should see "Acesso efetuado com sucesso."

    Scenario: Professor cannot create a secretary
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        And I'm logged in as professor "arnaldo"
        And I should not see "Novo Funcionário"
        Then I try the create secretary URL
        Then I should see "ACESSO NEGADO"

    Scenario: Any person trying to create a secretary
        Given I'm at the home page
        Then I try the create secretary URL
        Then I should see "ACESSO NEGADO"
