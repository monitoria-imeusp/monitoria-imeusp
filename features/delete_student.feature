Feature: delete a student
	In order to delete a student
	As a admin
	I want to delete a student

	Scenario: Admin deletes a student
		Given I'm at the login page
    	And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
    	When I fill the "Email" field with "kazuo@ime.usp.br"
    	And I fill the "Password" field with "admin123"
    	And I press the "Sign in" button
    	And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and adress "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Lista de Alunos" link
    	And I click the "Remover" link
    	And I should not see "carlinhos"

    Scenario: Professor can't delete a student
    	Given I'm at the professor login page
        And There is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and adress "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Lista de Alunos" link
    	And I should not see "Remover"