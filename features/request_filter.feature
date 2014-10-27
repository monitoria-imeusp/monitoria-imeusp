Feature: Filtering requests for teaching assistant
    In order to ignore other department requests
    As a superprofessor
    I want to filter the requests by department

    Background:
        Given there is an open semester "2014" "1"
        And I'm at the professor login page
        And there is a department with code "MAC"
        And there is a department with code "MAE"
        And there is a super_professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Bob2" and password "prof-123" nusp "1234" department "MAC" and email "bob2@bob.bob"
        And there is a professor with name "Bob3" and password "prof-123" nusp "1235" department "MAE" and email "bob3@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0112" and department "MAC"
        And there is a course with name "Coisas2" and code "MAC0113" and department "MAC"
        And there is a course with name "Coisas3" and code "MAE0114" and department "MAE"
        And there is a course with name "Coisas4" and code "MAE0115" and department "MAE"
        And there is a request for teaching assistant with professor "Bob2" and course "MAC0110" and requested_number "2" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob2" and course "MAC0112" and requested_number "4" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0113" and requested_number "20" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob3" and course "MAE0114" and requested_number "2" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob3" and course "MAE0115" and requested_number "4" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I click the "Pedidos de Monitoria" link


    Scenario: Another professor from the same department
        Then I should see "MAC0110"
        And I should see "MAC0112"
        And I should see "MAC0113"

    Scenario: Another professor from another department
        Then I should not see "MAE0114"
        And I should not see "MAE0115"
        And I should see "MAC0113"
