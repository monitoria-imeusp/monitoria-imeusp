Feature: Login Student
    In order to login the system/apply for teaching assistant
    As a student
    I want to login in the system

    Scenario: Valid credentials
        Given I'm at the user login page
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        Then I should see "Acesso efetuado com sucesso."
