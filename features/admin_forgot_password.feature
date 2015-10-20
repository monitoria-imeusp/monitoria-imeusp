Feature: Forgot the password
    In order to test the forgot your password
    As an administrator
    I want to see the message that an email was sent
    
    Background:
        Given there is a closed but active semester 2015/2

    Scenario: Clicking forgot password
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with "kazuo@ime.usp.br"
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Dentro de minutos, você receberá um e-mail com as instruções de reinicialização da sua senha."

    Scenario: Clicking forgot password with wrong email
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with "kazuo233@ime.usp.br"
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Não foi possível salvar admin: 1 erro"
        And I should see "Email não encontrado"

    Scenario: Clicking forgot password with empty email
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with ""
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Não foi possível salvar admin: 1 erro"
        And I should see "Email não pode ficar em branco"
