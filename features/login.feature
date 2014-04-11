Feature: Login
    In order to manage the system
    As an administrator
    I want to login to the system

    Scenario: Valid credentials
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        Then I should see "Signed in successfully."

    Scenario: After exitting the page and entering it again
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And I'm at the login page
        Then I should see "Bem-vindo ao sistema de monitoria do IME-USP!"
        And I should see "kazuo@ime.usp.br"
