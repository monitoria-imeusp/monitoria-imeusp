Feature: Forgot the password secretary
    In order to test the forgot your password
    As a secretary
    I want to see the message that an email was sent

    Scenario: Clicking forgot password
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with "secretaria@ime.usp.br"
        And I press the "Send me reset password instructions" button
        Then I should see "Dentro de minutos, você receberá um e-mail com as instruções de reinicialização da sua senha."

    Scenario: Clicking forgot password with wrong email
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with "sectaria@ime.usp.br"
        And I press the "Send me reset password instructions" button
        Then I should see "Não foi possível salvar secretary: 1 erro"
        And I should see "Email não encontrado"

    Scenario: Clicking forgot password with empty email
        Given I'm at the secretary login page
        And there is a secretary with name "secretaria" and password "12345678" nusp "1111111" and email "secretaria@ime.usp.br"
        When I click the "Esqueceu sua senha?" link
        And I fill the "Email" field with ""
        And I press the "Send me reset password instructions" button
        Then I should see "Não foi possível salvar secretary: 1 erro"
        And I should see "Email translation missing: pt-BR.activerecord.errors.models.secretary.attributes.email.blank"
