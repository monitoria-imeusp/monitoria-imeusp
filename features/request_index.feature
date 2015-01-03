Feature: Index of the Requests for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to list the requests of teaching assistant

    Background:
        Given there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a department with code "MAE"
        And there is a professor with name "Bob" and password "prof-123" nusp "12333" department "MAC" and email "bob@bob.bob"
        And there is a super_professor with name "Mandel" and password "prof-123" nusp "12344" department "MAC" and email "kira@bob.bob"
        And there is a professor with name "Claudia" and password "prof-123" nusp "12355" department "MAE" and email "claudia@ime.br"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0122" and department "MAC"
        And there is a course with name "Estatística Concorrente" and code "MAE0438" and department "MAE"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Mandel" and course "MAC0122" and requested_number "2" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Claudia" and course "MAE0438" and requested_number "2" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"

    Scenario: Check request assistant table and professor can't see the other professor's request
        Given I'm at the professor login page
        When I fill the "Número USP" field with "12333"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should see "MAC0110 - Mascarenhas"
        And I should not see "MAC0122 - Coisas"
        And I should see "1"
        And I click the "Ver" link
        And I should see "Atendimento aos alunos: Não"
        And I should see "Correção de trabalhos: Sim"
        And I should see "Fiscalização de provas: Sim"

    Scenario: Superprofessor see only requests of his department
        Given I'm at the professor login page
        When I fill the "Número USP" field with "12344"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should see "MAC0110 - Mascarenhas"
        And I should see "MAC0122 - Coisas"
        And I should not see "MAE0438 - Estatística Concorrente"

    Scenario: Hiperprofessor see only requests of his department
        Given I'm at the professor login page
        And there is a hiper_professor with name "zara" and password "12345678" nusp "2222222" department "MAE" and email "zara@usp.br"
        When I fill the "Número USP" field with "2222222"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should see "MAC0110 - Mascarenhas"
        And I should see "MAC0122 - Coisas"
        And I should see "MAE0438 - Estatística Concorrente"