Feature: Assistant roles creation
    In order to manage the assistant roles
    As a superprofessor or secretary
    I want to create assistant roles

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a student with name "John" with nusp "654321" and email "aluno2@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"
        And there is a candidature by student "John" for course "MAC0110"


    Scenario: Super professor creates an assistant role
        Given I'm logged in as a super professor
        And I visit a request page
        And I click the first "Eleger" link
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"

    Scenario: Undergraduate student history is displayed correctly
        Given I'm logged in as a super professor
        And I visit a request page
        Given the undergraduate student with nusp "123456" has valid history
        And I can't do real web requests
        And I click the first "Detalhes" link
        Then I should see "MAT0111 3.0 Reprovado por nota e frequência"
        And I should see "MAC0420 4.9 Reprovado por nota"
        And I should see "MAC0420 9.0 Reprovado por frequência"
        And I should see "MAC0323 0.0 Trancado"
        And I should see "MAC0315 5.0 Aprovado"
        And I should see "MAC0300 0.0 Matriculado"
        Then I can do real web requests

    Scenario: Graduate student history is displayed correctly
        Given I'm logged in as a super professor
        And I visit a request page
        Given the graduate student with nusp "654321" has valid history
        And I can't do real web requests
        And I click the second "Detalhes" link
        Then I should see "MAT4578 A"
        And I should see "MAC6711 A"
        And I should see "MAC5915 C"
        And I should see "MAC5786 A"
        And I should see "MAC5716 A"
        And I should see "MAC5714 B"
        Then I can do real web requests

    Scenario: Secretary sees creates an assistant role
        Given I'm logged in as a secretary
        And I visit a request page
        And I click the first "Eleger" link
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
