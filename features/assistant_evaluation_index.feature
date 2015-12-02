Feature: Assistant evaluation index
    In order to evaluate assistant roles
    As a professor
    I want to see a assistant's evaluations

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"
        And there is an assistant evaluation for student "Bob" with professor "Dude" at course "MAC0110" as "ok"

    Scenario: Professor lists assistant evaluations
        Given I'm logged in as super professor from the "MAC" department
        When I visit student "Bob"'s page
        And I click the "Ver avaliações como monitor(a)" link
        Then I should see "Bob Avaliações"
        And I should see "ok"
