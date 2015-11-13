Feature: Assistant evaluation edition
    In order to evaluate assistant roles
    As a professor
    I want to edit assistant evaluations

    Background:
        When there is an active semester "2014" "1" during evaluation period
        And there is a department with code "MAC"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a candidature by student "Bob" for course "MAC0110"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"
        And there is an assistant evaluation for student "Bob" with professor "Dude" at course "MAC0110" as "ok"

    Scenario: Professor edits assistant evaluation
        Given I'm logged in as professor "Dude"
        And I visit my assistant roles page
        When I click the "Mudar avaliação" link
        And I fill the assistant evaluation fields
        And I press the "Enviar avaliação" button
        Then I should see "Avaliação atualizada com sucesso"
