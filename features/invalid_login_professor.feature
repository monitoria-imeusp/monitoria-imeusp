Feature: Invalid professor login
    In order to test the login
    As an professor
    I want to fail the login

    Scenario: Invalid nusp
        Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "111111"
        And I fill the "Password" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."

    Scenario: Invalid passowrd
        Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "1234567"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."