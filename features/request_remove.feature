Feature: Removing Requests for Teaching Assistant
  In order to remove requests for teaching assistant
  As a professor
  I want to remove requests of teaching assistant

    @javascript
    Scenario: Valid professor deleting a request
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        Then I click the "Pedidos de Monitoria" link
        And I click the "Ver" link
        And I click the "Remover" link
        And I should see "Você tem certeza?" in the alert
        And I confirm the alert
        Then I should not see "MAC0122"

