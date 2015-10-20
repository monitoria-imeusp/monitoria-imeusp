Feature: Invalid secretary login
    In order to test the login
    As an secretary
    I want to fail the login
    
    Background:
        Given there is a closed but active semester 2015/2
        And I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"

    Scenario: Invalid nusp
        When I fill the "Número USP" field with "111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."

    Scenario: Invalid passowrd
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "1234567"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."
