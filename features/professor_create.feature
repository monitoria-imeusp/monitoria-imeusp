Feature: Creating professor
	In order to allow professors to use the system
	As a admin
	I want to create a professor

    Background:
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a department with code "MAE"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button

	Scenario: Valid data
        And I'm ready to receive email
        Then I click the "Cadastrar professor" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I select "MAE" on the "Departamento"
        And I fill the "Email" field with "gold@troll.com"
        And I select the professor rank option "Membro da comissão de monitoria"
        And I press the "Enviar" button
        And I click the "Sair" link
        When I confirm the professor account with email "gold@troll.com" and sign in
        Then I should see "Acesso efetuado com sucesso."

    Scenario: Don't select departament
        Then I click the "Cadastrar professor" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I fill the "Email" field with "gold@troll.com"
        And I select the professor rank option "Membro da comissão de monitoria"
        And I press the "Enviar" button
        Then I should see "Department não pode ficar em branco"

    Scenario: Not filling nusp
        Then I click the "Cadastrar professor" link
        And I fill the "Nome" field with "Gold"
        And I select "MAE" on the "Departamento"
        And I fill the "Email" field with "gold@troll.com"
        And I select the professor rank option "Membro da comissão de monitoria"
        And I press the "Enviar" button
        Then I should see "Número USP não pode ficar em branco"

    Scenario: Not filling email
        Then I click the "Cadastrar professor" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I select "MAE" on the "Departamento"
        And I select the professor rank option "Membro da comissão de monitoria"
        And I press the "Enviar" button
        Then I should see "Email não pode ficar em branco"