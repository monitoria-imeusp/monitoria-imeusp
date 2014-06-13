Feature: Forgot the password professor
    In order to test the forgot your password
    As a professor
    I want to see the message that an email was sent

    Background:
        Given I'm at the professor login page
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        And I click the "Esqueceu sua senha?" link

    Scenario: Clicking forgot password
        When I fill the "Email" field with "devil@usp.br"
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Dentro de minutos, você receberá um e-mail com as instruções de reinicialização da sua senha."

    Scenario: Clicking forgot password with wrong email
        When I fill the "Email" field with "devi@usp.br"
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Não foi possível salvar professor: 1 erro"
        And I should see "Email não encontrado"

    Scenario: Clicking forgot password with empty email
        When I fill the "Email" field with ""
        And I press the "Enviar o email com instruções para obter nova senha" button
        Then I should see "Não foi possível salvar professor: 1 erro"
        And I should see "Email não pode ficar em branco"
