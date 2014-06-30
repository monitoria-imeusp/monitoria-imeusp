Feature: Professor logout
    In order to leave the system
    As an professor
    I want to logout of the system

    Scenario: Successful Logout
        Given I'm at the professor login page
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Sair" link
        Then I should see "Sessão encerrada com sucesso."
