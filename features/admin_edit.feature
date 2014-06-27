Feature: Editing the admin
	In order to edit the admin
	As admin
	I want to edit my account

	Background:
		Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"

	Scenario: Admin edits its own information
		When I'm at the home page
		And I click the "Login Admin" link
        Then I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
		And I click the "Meu Perfil" link
		And I click the "Editar" link
        Then I fill the "Email" field with "kazuou@ime.usp.br"
        And I fill the "Senha" field with "00000000"
        And I fill the "Confirme a senha" field with "00000000"
        And I press the "Enviar" button
        Then I should see "Email: kazuou@ime.usp.br"

