Feature: Invalid student login
    In order to test the student login
    As a student
    I want to fail the login

    Background:
        Given I'm at the user login page
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"


    Scenario: Invalid nusp
        When I fill the "Número USP" field with "123457"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."

    Scenario: Invalid passowrd
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme?"
        And I press the "Entrar" button
        Then I should see "Credenciais inválidas."
