Feature: Assistant roles table visualization
    In order to manage my assistant roles
    As a professor
    I want to see my assistant roles

    Background:
        When there is an open semester "2014" "0"
        And there is a department with code "MAC"
        And there is a department with code "MAT"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a course with name "Laboratório de programação eXtrema" and code "MAC0431" and department "MAC"
        And there is a course with name "Algebra II" and code "MAT0125" and department "MAT"
        And there is a student with name "John" with nusp "123457" and email "john@usp.br"
        And there is a student with name "Wil" with nusp "11112" and email "wil@usp.br"
        And there is a student with name "Mary" with nusp "22221" and email "mary@usp.br"
        And there is a student with name "Alfredo" with nusp "666" and email "alfredinho@usp.br"
        And there is a professor with name "Gold" and nusp "87777" and department "MAC" and email "gold@ime.usp.br"
        And there is a professor with name "Silver" and nusp "77778" and department "MAT" and email "silver@ime.usp.br"
        And there is a request for teaching assistant by professor "Gold" for the course "MAC0431"
        And there is a request for teaching assistant by professor "Silver" for the course "MAT0125"
        And there is a candidature by student "John" for course "MAC0431"
        And there is a candidature by student "Wil" for course "MAC0431"
        And there is a candidature by student "Mary" for course "MAT0125"
        And there is a candidature by student "Alfredo" for course "MAC0431"
        And there is an assistant role for student "John" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Wil" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Mary" with professor "Silver" at course "MAT0125"
        And there is a deactivated assistant role for student "Alfredo" with professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "false" for student "John" and professor "Gold" at course "MAC0431"        
        And there is an assistant frequency with month "3" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "true" for student "Alfredo" and professor "Gold" at course "MAC0431"        
        And there is an assistant frequency with month "3" with presence "false" for student "Alfredo" and professor "Gold" at course "MAC0431"

    Scenario: Professor sees his assistants
        And I'm logged in as professor "Gold"
        And I visit my assistant roles page
        Then I should see "John"
        And I should see "Wil"
        And I should not see "Mary"
        And I should see "MAC0431"


    Scenario: Professor sees the correct frequencies
        Given it's currently month 5
        And I'm logged in as professor "Gold"
        And I visit my assistant roles page
        Then I should see "John Monitor ativo de MAC0431 Março: --- Abril: Ausente Maio: --- Junho: --- Avaliar"
        Then I should see "Wil Monitor ativo de MAC0431 Março: Presente Abril: Presente Maio: --- Junho: --- Avaliar"
        Then I should see "Alfredo Monitor desativado de MAC0431 Desativado Avaliar"
        Then I'm back to current time

    Scenario: Professor marks frequency
        Given it's currently month 5
        And month 5 of semester 1/2014 is open for frequency
        And I'm logged in as professor "Gold"
        And I visit my assistant roles page
        When I press the first "Presente" button
        Then I should see "John Monitor ativo de MAC0431 Março: --- Abril: Ausente Maio: Presente Junho: --- Avaliar"
        And I should see "Wil Monitor ativo de MAC0431 Março: Presente Abril: Presente Maio: Junho: --- Avaliar"
        And I should see "Alfredo Monitor desativado de MAC0431 Desativado Avaliar"
        And I press the first "Ausente" button
        And I should see "John Monitor ativo de MAC0431 Março: --- Abril: Ausente Maio: Presente Junho: --- Avaliar"
        And I should see "Wil Monitor ativo de MAC0431 Março: Presente Abril: Presente Maio: Ausente Junho: --- Avaliar"
        And I should see "Alfredo Monitor desativado de MAC0431 Desativado Avaliar"
        And I'm back to current time

