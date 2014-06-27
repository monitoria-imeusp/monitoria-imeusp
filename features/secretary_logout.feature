Feature: Secretary logout
    In order to leave the system
    As an secretary
    I want to logout of the system

    Scenario: Successful Logout
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Logout" link
        Then I should see "Logout efetuado com sucesso."
