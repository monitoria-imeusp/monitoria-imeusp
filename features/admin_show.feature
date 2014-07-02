Feature: Showing the admin
	In order to see the admin
	As admin
	I want to see my account

	Background:
		Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"

	Scenario: Admin seeing its own detailed information
		When I'm at the system access page
		And I click the "Login Admin" link
        Then I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
		And I click the "Meu Perfil" link
		Then I should see "Email: kazuo@ime.usp.br"
		And I should see "Editar"
