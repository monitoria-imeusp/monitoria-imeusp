Feature: delete a student
	In order to delete a student
	As an admin or as a secretary
	I want to delete a student

    Background:
        Given there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"


    Scenario: Admin deletes a student
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
    	And I go to the students index
        And I click the "Ver perfil" link
    	And I click the "Remover" link
    	And I should not see "carlinhos"


    Scenario: Secretary deletes a student
        Given I'm at the secretary login page
        And there is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I go to the students index
        And I click the "Ver perfil" link
        And I should see "Remover"
        And I click the "Remover" link
        And I should not see "carlinhos"

    Scenario: Professor can't delete a student
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        And I'm logged in as professor "mandel"
    	And I go to the students index
        And I click the "Ver perfil" link
    	And I should not see "Remover"
    	
	Scenario: Student can't delete itself
	    And I'm logged in as student "carlinhos"
	    And I click the "Perfil" link
	    And I should not see "Remover"

