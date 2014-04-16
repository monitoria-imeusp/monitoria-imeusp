Feature: Professor logout
    In order to leave the system
    As an professor
    I want to logout of the system

    Scenario: Successful Logout
        Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And I click the "Logout" link
        Then I should see "Logout efetuado com sucesso."
