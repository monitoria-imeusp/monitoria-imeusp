Feature: Invalid login
    In order to test the login
    As an administrator
    I want to fail the login

    @javascript
    Scenario: Invalid email
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        Then I should see "Invalid email or password."
    
    @javascript
    Scenario: Not email
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuoime.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        Then I should see "Please enter an email address."
