Feature: edit a student
	In order to edit a student
	As a student
	I want to edit my profile

    Background:
		Given I'm at the user login page
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a student with name "carlinhos2" with nusp "1234567" and email "eu2@usp.br"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button

    Scenario: Student edits his or hers user profile
    	And I click the "Perfil" link
        And I click the first "Editar" link
        And I fill the "Nome Completo" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I fill the "Confirme a senha" field with "12345678"
        And I press the "Salvar" button
        Then I should see "Carlinhos"

    Scenario: Student edits his or hers student profile
        When I click the "Perfil" link
        And I click the second "Editar" link
        And I fill the "Endereço" field with "Narnia"
        And I press the "Salvar" button
        And I should see "Narnia"

    Scenario: Student fails to edit his or hers profile
        And I click the "Perfil" link
        And I click the first "Editar" link
        And I fill the "Nome Completo" field with "Carlinhos"
        And I fill the "Senha" field with "12345678"
        And I press the "Salvar" button
        Then I should not see "Carlinhos"


    Scenario: Student trying to edit a student that isn't him
        When I try to access the "students" page with id "2" to "edit"
        Then I should see "Acesso negado"

	#Scenario: Student trying to update a student that doesn't exist
		#When I try to update the student with id "44"
		#And I click the "redirected" link
		#Then I should see "Bem-vindo ao sistema de monitoria do IME-USP!"
