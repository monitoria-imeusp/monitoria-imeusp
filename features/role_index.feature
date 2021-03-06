Feature: Assistant roles table visualization
    In order to manage the assistant roles
    As a superprofessor or secretary
    I want to see the list of all assistant roles

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a department with code "MAT"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a course with name "Laboratório de programação eXtrema" and code "MAC0431" and department "MAC"
        And there is a course with name "Algebra II" and code "MAT0125" and department "MAT"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a student with name "John" with nusp "123457" and email "john@usp.br"
        And there is a student with name "Wil" with nusp "11112" and email "wil@usp.br"
        And there is a student with name "Mary" with nusp "22221" and email "mary@usp.br"
        And there is a student with name "Alfredo" with nusp "666" and email "alfredinho@usp.br"
        And there is a student with name "Jude" with nusp "555" and email "jude@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a professor with name "Gold" and nusp "87777" and department "MAC" and email "golddev@ime.usp.br"
        And there is a professor with name "Silver" and nusp "77778" and department "MAT" and email "silver@ime.usp.br"
        And there is a super_professor with name "Nina" and nusp "99987" and department "MAC" and email "ninadev@ime.usp.br"
        And there is a super_professor with name "Eloi" and nusp "78546" and department "MAT" and email "eloidev@ime.usp.br"
        And there is a hiper_professor with name "Zara" and password "changeme!" nusp "99986" department "MAT" and email "zaradev@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a request for teaching assistant by professor "Gold" for the course "MAC0431"
        And there is a request for teaching assistant by professor "Silver" for the course "MAT0125"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"
        And there is an assistant role for student "John" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Wil" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Mary" with professor "Silver" at course "MAT0125"
        And there is an assistant role for student "Jude" with professor "Gold" at course "MAC0431"
        And there is a deactivated assistant role for student "Alfredo" with professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "3" with presence "false" for student "Bob" and professor "Dude" at course "MAC0110"
        And there is an assistant frequency with month "4" with presence "true" for student "Bob" and professor "Dude" at course "MAC0110"
        And there is an assistant frequency with month "5" with presence "true" for student "Bob" and professor "Dude" at course "MAC0110"        
        And there is an assistant frequency with month "3" with presence "true" for student "John" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "false" for student "John" and professor "Gold" at course "MAC0431"        
        And there is an assistant frequency with month "3" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "5" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "3" with presence "false" for student "Mary" and professor "Silver" at course "MAT0125"
        And there is an assistant frequency with month "4" with presence "true" for student "Alfredo" and professor "Gold" at course "MAC0431"

    Scenario: Super professor sees his department assistant roles
        Given it's currently month 5
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
        And I should not see "Mary"
        And I should not see "MAT0125"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And I'm back to current time

    Scenario: Secretary sees all assistant roles
        Given it's currently month 5
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
        And I should not see "Mary"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And I'm back to current time

    Scenario: Hiperprofessor sees all assistant roles
        Given it's currently month 5
        Given I'm logged in as professor "Zara"
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should not see "Mary"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And I'm back to current time

    Scenario: Common professor cannot see all assistant roles
        Given I'm logged in as a professor
        And I visit the assistant roles page
        Then I should see "ACESSO NEGADO"


    Scenario: Secretary requests assistant evaluations
        Given I'm ready to receive email
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        And I click the "Pedir avaliações dos professores" link
        Then the assistant evaluation reminder email for semester "1" of year "2014" should have been delivered properly to "prof@ime.usp.br"
        And the assistant evaluation reminder email for semester "1" of year "2014" should have been delivered properly to "golddev@ime.usp.br"
        And the assistant evaluation reminder email for semester "1" of year "2014" should have been delivered properly to "silver@ime.usp.br"
        And I should see "Solicitações enviadas aos professores"
        
