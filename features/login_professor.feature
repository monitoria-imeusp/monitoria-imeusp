Feature: Login Professor
    In order to login the system/ ask for monitor
    As an professor
    I want to login to the system

    Scenario: Valid credentials
        Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Login efetuado com sucesso."

    Scenario: After exitting the page and entering it again
        Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Entrar" button
        And I'm at the login page
        Then I should see "Sistema de monitoria"
        And I should see "devil@usp.br"
