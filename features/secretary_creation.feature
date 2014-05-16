Feature: Secretary creation
    In order to create a secretary
    As an admin
    I want to create a secretary

    Scenario: Admin creating a secretary
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Nova Secretária" link
        And I fill the "Número USP" field with "1234567"
        And I fill the "Nome" field with "Marcia"
        And I fill the "Email" field with "marcia@ime.usp.br"
        And I fill the "Senha" field with "12345678"
        And I press the "Cadastrar" button
        Then I should see "Secretária foi criada com sucesso."
        And I should see "Número USP: 1234567"
        And I should see "Nome: Marcia"
        And I should see "Email: marcia@ime.usp.br"
        And I should see "Editar"

    Scenario: Professor cannot create a secretary
        Given I'm at the professor login page
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I should not see "Nova Secretária"
        Then I try the create secretary URL
        Then I should see "Para continuar, faça login ou registre-se."

    Scenario: Any person trying to create a secretary
        Given I'm at the home page
        Then I try the create secretary URL
        Then I should see "Para continuar, faça login ou registre-se."