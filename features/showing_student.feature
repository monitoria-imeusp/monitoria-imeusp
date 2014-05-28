Feature: Seeing information
	In order to see the complete student information
	As a professor or admin
	I want to see a student information

	Scenario: Professor look for student information 
    	Given I'm at the professor login page
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and adress "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Alunos" link
    	And I click the "Visualizar" link
    	And I should see "Nome: carlinhos"
    	And I should see "RG: 123"

    Scenario: Admin look for student information
		Given I'm at the login page
    	And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
    	When I fill the "E-mail" field with "kazuo@ime.usp.br"
    	And I fill the "Senha" field with "admin123"
    	And I press the "Entrar" button
    	And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and adress "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Alunos" link
		And I click the "Visualizar" link
    	And I should see "Nome: carlinhos"
    	And I should see "RG: 123"    	    	