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
        And there is a student with name "Alberto" with nusp "123587" and email "alb@usp.br"
        And there is a student with name "Dude" with nusp "55" and email "dud@usp.br"
        And there is a student with name "Duda" with nusp "56" and email "duda@usp.br"
        And there is a student with name "Elbert" with nusp "65" and email "elb@usp.br"
        And there is a course with name "Introdução" and code "MAC0110" and department "MAC"
        And there is a course with name "LabXP" and code "MAC0666" and department "MAC"
        And there is a request for teaching assistant with professor "zara" and course "MAC0110" and requested_number "3" and priority "1" and student_assistance "false" and work_correction "false" and test_oversight "false"
        And there is a request for teaching assistant by professor "zara" for the course "MAC0666"
        And there is a candidature by student "Rogerio" for course "MAC0110"
        And there is a candidature by student "Caio" for course "MAC0666"
        And there is a candidature by student "Elbert" for course "MAC0666"
        And there is a candidature by student "Alberto" for course "MAC0110"
        And there is a candidature by student "Dude" for course "MAC0110"
        And there is a candidature by student "Duda" for course "MAC0110"
        And I'm logged in as professor "zara"
        Then I click the "Pedidos de monitoria" link


    Scenario: No elected candidatures
        And I should see "LabXP"
        Then I click the first "Detalhes" link
        And I should see "Disciplina: MAC0110 - Introdução"
        And I click the "Eleger monitor" link
        Then "123456" elected status should be "Não"
        Then "123457" elected status should be "Não"
        And "Alberto" should appear before "Duda"
        And "Duda" should appear before "Dude"
        And "Dude" should appear before "Rogerio"
        And "Rogerio" should appear before "Caio"
        And "Caio" should appear before "Elbert"

    Scenario: Some elected candidatures
        And I should see "LabXP"
        Then I click the first "Detalhes" link
        And I should see "Disciplina: MAC0110 - Introdução"
        And I click the "Eleger monitor" link
        Then I click the first "Eleger" link
        Then I click the "Pedidos de monitoria" link
        Then I click the second "Detalhes" link
        And I should see "Disciplina: MAC0666 - LabXP"
        And I click the "Eleger monitor" link
        Then "123587" elected status should be "Sim"
        Then "123457" elected status should be "Não"

    Scenario: Repeated candidates
        And I should see "LabXP"
        Then I click the first "Detalhes" link
        And I should see "Disciplina: MAC0110 - Introdução"
        And I should not see "Ver dados"
        And I click the "Eleger monitor" link
        Then I click the first "Eleger" link
        And I click the "Eleger monitor" link
        Then I click the first "Eleger" link
        And I click the "Eleger monitor" link
        Then I click the first "Eleger" link
        Then I should not see "Eleger monitor"
        And I should see "Ver dados"
