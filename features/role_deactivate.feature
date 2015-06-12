Feature: Assistant roles deactivation
    In order to manage the assistant roles
    As a superprofessor or secretary
    I want to deactivate assistant roles

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a course with name "Introdução" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"

    Scenario: Super professor tries to deactivate an assistant role
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        And I should not see "Desativar"
        
    Scenario: Secretary deactivates an assistant role
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        And I click the "Desativar" link
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
        And I should see "Desativado"

    Scenario: Normal professor sees which assistants are active and inactive
        Given I'm logged in as professor "Dude"
        And there is a student with name "Blarg" with nusp "123459" and email "aluani@usp.br"
        And there is a deactivated assistant role for student "Blarg" with professor "Dude" at course "MAC0110"
        And I visit my assistant roles page
        And "Bob" active status should be "Sim"
        And "Blarg" active status should be "Não"
