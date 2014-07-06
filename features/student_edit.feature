Feature: edit a student
	In order to edit a student
	As a student
	I want to edit my profile

    Background:
		Given I'm at the student login page
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a student with name "carlinhos2" and password "12345678" and nusp "1234567" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu2@usp.br" and has_bank_account "false"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button

    Scenario: Student edits his or hers profile
    	And I click the "Meu Perfil" link
        And I click the "Editar" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "Confirme a senha" field with "12345678"
        And I select the gender option "Masculino"
        And I press the "Salvar" button
        Then I should see "Carlinhos"
        And I should see "Masculino"

    Scenario: Student fails to edit his or hers profile
        And I click the "Meu Perfil" link
        And I click the "Editar" link
        And I fill the "Nome" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I select the gender option "Masculino"
        And I press the "Salvar" button
        Then I should not see "Carlinhos"
    
    
    Scenario: Student trying to edit a student that isn't him
        When I try to access the "students" page with id "2" to "edit"
        Then I should see "Acesso negado"
    
    Scenario: Student trying to update a student that doesn't exist
		When I try to update the student with id "44"
        And I click the "redirected" link
        Then I should see "Bem-vindo ao sistema de monitoria do IME-USP!"
