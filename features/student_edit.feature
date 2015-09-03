Feature: edit a student
	In order to edit a student
	As a student
	I want to edit my profile

    Background:
		Given I'm at the user login page
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a student with name "carlinhos2" with nusp "1234567" and email "eu2@usp.br"
        And I'm logged in as student "carlinhos"

    Scenario: Student edits his or hers student profile
        When I click the "Perfil" link
        And I click the "Editar" link
        And I fill the "Endereço" field with "Narnia"
        And I press the "Salvar" button
        And I should see "Narnia"

    Scenario: Student trying to edit a student that isn't him
        When I try to access the "students" page with id "2" to "edit"
        Then I should see "ACESSO NEGADO"