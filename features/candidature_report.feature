Feature: Candidature report
    In order to report
    As a student
    I want to report

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a course with name "Introdução" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"

    Scenario: Student sees the report link
        Given it's currently month 6
        And I'm logged in as student "Bob"
        And I click the "Minhas candidaturas" link
        Then I should see "Preencher relatório"

    Scenario: Student doesn't see the report link
        Given it's currently month 5
        And I'm logged in as student "Bob"
        And I click the "Minhas candidaturas" link
        Then I should not see "Preencher relatório"
