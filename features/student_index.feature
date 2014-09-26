Feature: Seeing information of the students
	In order to see the information of the students
	As a professor or admin
	I want to see the information of the students

	Scenario: Professor look for student information
    	Given I'm at the professor login page
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
    	And I click the "Alunos" link
    	And I click the "carlinhos" link
    	And I should see "Nome: carlinhos"
        And I should see "Número USP: 123456"
    	And I should see "RG: 1"


