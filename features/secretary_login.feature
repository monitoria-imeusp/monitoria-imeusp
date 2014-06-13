Feature: Login Secretary
    In order to login the system/ ask for monitor
    As an secretary
    I want to login to the system

    Scenario: Valid credentials
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Login efetuado com sucesso."
        And I should see "Sistema de Monitoria"
        And I should see "secretaria@ime.usp.br"
