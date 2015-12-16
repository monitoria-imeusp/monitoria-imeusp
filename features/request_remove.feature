Feature: Removing Requests for Teaching Assistant
  In order to remove requests for teaching assistant
  As a professor
  I want to remove requests of teaching assistant

    @javascript
    Scenario: Valid professor deleting a request
        Given there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123456" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And I'm logged in as professor "Bob"
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I click the "Detalhes" link
        And I click the "Remover" link
        Then I should not see "MAC0122"

