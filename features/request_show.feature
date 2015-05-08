Feature: Show a request for teaching assistant
    In order to manage requests for teaching assistant
    As a super professor
    I want to show a request for teaching assistant

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a hiper_professor with name "zara" and password "12345678" nusp "2222222" department "MAE" and email "zara@usp.br"
        And there is a student with name "Rogerio" with nusp "123456" and email "eu@usp.br"
        And there is a student with name "Caio" with nusp "123457" and email "eu2@usp.br"
        And there is a course with name "Introdução" and code "MAC0110" and department "MAC"
        And there is a course with name "LabXP" and code "MAC0666" and department "MAC"
        And there is a request for teaching assistant by professor "zara" for the course "MAC0110"
        And there is a request for teaching assistant by professor "zara" for the course "MAC0666"
        And there is a candidature by student "Rogerio" for course "MAC0110"
        And there is a candidature by student "Caio" for course "MAC0666"
        Given I'm at the professor login page
        When I fill the "Número USP" field with "2222222"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I click the "Pedidos de monitoria" link


    Scenario: No elected candidatures
        And I should see "LabXP"
        Then I click the first "Ver" link
        And I should see "Disciplina: MAC0110 - Introdução"
        Then "123456" elected status should be "Não"
        Then "123457" elected status should be "Não"
        
    Scenario: Some elected candidatures
        And I should see "LabXP"
        Then I click the first "Ver" link
        And I should see "Disciplina: MAC0110 - Introdução"
        Then I click the first "Eleger" link
        Then I click the "Voltar" link
        Then I click the second "Ver" link
        And I should see "Disciplina: MAC0666 - LabXP"
        Then "123456" elected status should be "Sim"
        Then "123457" elected status should be "Não"

