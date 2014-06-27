Feature: Index of the Requests for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to list the requests of teaching assistant
    
    Scenario: Check request assistant table and not see the other teacher's request
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Mandel" and password "prof-123" nusp "1234" department "MAC" and email "kira@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0122" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Mandel" and course "MAC0122" and requested_number "2" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        Then I click the "Pedidos de Monitoria" link
        And I should see "MAC0110"
        And I should not see "MAC0122"
        And I should see "1"
        And I click the "Ver" link
        And I should see "Atendimento aos alunos: Não"
        And I should see "Correção de trabalhos: Sim"
        And I should see "Fiscalização de provas: Sim"