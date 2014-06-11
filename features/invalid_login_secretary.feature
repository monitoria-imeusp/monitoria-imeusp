Feature: Invalid secretary login
    In order to test the login
    As an secretary
    I want to fail the login

    Scenario: Invalid nusp
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I fill the "Número USP" field with "111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."

    Scenario: Invalid passowrd
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "1234567"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."
