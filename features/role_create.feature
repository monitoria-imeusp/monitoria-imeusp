Feature: Assistant roles creation
    In order to manage the assistant roles
    As a superprofessor or secretary
    I want to create assistant roles

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"

    Scenario: Super professor sees all assistant roles
        Given I'm logged in as a super professor
        And I visit a request page
        And I click the "Eleger" link
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"

    Scenario: Secretary sees all assistant roles
        Given I'm logged in as a secretary
        And I visit a request page
        And I click the "Eleger" link
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"