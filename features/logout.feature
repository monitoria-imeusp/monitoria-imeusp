Feature: Logout
    In order to manage the system
    As an administrator
    I want to logout of the system

    Scenario: Successful Logout
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And I click the "Logout" link
        Then I should see "Logout efetuado com sucesso."
