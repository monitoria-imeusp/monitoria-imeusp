Feature: Filtering requests for teaching assistant
    In order to ignore other department requests
    As a superprofessor
    I want to filter the requests by department

    Scenario: Another professor from the same department
        Given I'm at the professor login page
        And there is a super_professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Bob2" and password "prof-123" nusp "1234" department "MAC" and email "bob2@bob.bob"
        And there is a request for teaching assistant with professor "Bob2" and subject "MAC0110" and requested_number "2" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob2" and subject "MAC0112" and requested_number "4" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob" and subject "MAC0113" and requested_number "20" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I click the "Pedidos de Monitoria" link
        Then I should see "MAC0110"
        Then I should see "MAC0112"
        Then I should see "MAC0113"

    Scenario: Another professor from another department
        Given I'm at the professor login page
        And there is a super_professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Bob2" and password "prof-123" nusp "1234" department "MAE" and email "bob2@bob.bob"
        And there is a request for teaching assistant with professor "Bob2" and subject "MAE0110" and requested_number "2" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob2" and subject "MAE0112" and requested_number "4" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Bob" and subject "MAC0113" and requested_number "20" and priority "1" and student_assistance "true" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I click the "Pedidos de Monitoria" link
        Then I should not see "MAE0110"
        Then I should not see "MAE0112"
        Then I should see "MAC0113"
