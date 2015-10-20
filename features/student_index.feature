Feature: Seeing information of the students
	In order to see the information of the students
	As a professor or admin
	I want to see the information of the students
    
    Background:
        Given there is a closed but active semester 2015/2

	Scenario: Professor look for student information
        And there is a super_professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        And I'm logged in as professor "mandel"
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
    	And I go to the students index
    	And I click the "Ver perfil" link
    	And I should see "Nome: carlinhos"
        And I should see "Número USP: 123456"
    	And I should see "RG/RNE: 1"


