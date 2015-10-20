Feature: Course deletion
	In order to delete a course
	As a superprofessor or admin
    I want to remove a course

    Background:
        Given there is a closed but active semester 2015/2

    Scenario: Admin removing a course
    	Given I'm at the login page
        And there is a department with code "MAC"
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I go to the courses index
        And I click the "MAC0342" link
        And I click the "Remover" link
        And I should not see "labxp"
        And I should not see "mac0342"


    Scenario: Super professor removing a course
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I'm logged in as a super professor
        And I go to the courses index
        And I click the "MAC0342" link
        And I click the "Remover" link
        And I should not see "labxp"
        And I should not see "mac0342"

    Scenario: Professor cannot remove a course
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I'm logged in as a professor
        And I go to the courses index
        And I should not see "Remover"

    Scenario: Any person trying to remove a course
        Given I'm at the home page
        And I go to the courses index
        And I should not see "Remover"
