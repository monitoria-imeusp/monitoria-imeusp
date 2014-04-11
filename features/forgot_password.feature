Feature: Forgot the password
    In order to test the forgot your password
    As an administrator
    I want to see the message that an email was sent

    Scenario: Clicking forgot password
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Forgot your password?" link
        And I fill the "Email" field with "kazuo@ime.usp.br"
        And I press the "Send me reset password instructions" button
        Then I should see "You will receive an email with instructions on how to reset your password in a few minutes."
    
    Scenario: Clicking forgot password with wrong email
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Forgot your password?" link
        And I fill the "Email" field with "kazuo233@ime.usp.br"
        And I press the "Send me reset password instructions" button
        Then I should see "1 error prohibited this admin from being saved:"
        And I should see "Email not found"
    
    Scenario: Clicking forgot password with empty email
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Forgot your password?" link
        And I fill the "Email" field with ""
        And I press the "Send me reset password instructions" button
        Then I should see "1 error prohibited this admin from being saved:"
        And I should see "Email can't be blank"
