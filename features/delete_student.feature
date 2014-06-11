Feature: delete a student
	In order to delete a student
	As an admin or as a secretary
	I want to delete a student

	Scenario: Admin deletes a student
		Given I'm at the login page
    	And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
    	When I fill the "Email" field with "kazuo@ime.usp.br"
    	And I fill the "Senha" field with "admin123"
    	And I press the "Entrar" button
    	And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Alunos" link
        And I click the "carlinhos" link
    	And I click the "Remover" link
    	And I should not see "carlinhos"

        
    Scenario: Secretary deletes a student
        Given I'm at the secretary login page
        And there is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And I click the "Alunos" link
        And I click the "carlinhos" link
        And I should see "Remover"
        And I click the "Remover" link
        And I should not see "carlinhos"

    Scenario: Professor can't delete a student
    	Given I'm at the professor login page
        And there is a professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
    	And I click the "Alunos" link
        And I click the "carlinhos" link
    	And I should not see "Remover"