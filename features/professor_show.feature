Feature: Showing a professor
	In order to see one professor
	As anyone or admin
	I want to see the information of a professor

	Background:
		Given there is a super_professor with name "Bob" and password "prof-123" nusp "123456" department "MAC" and email "bob@bob.bob"
		And there is a professor with name "Gold" and password "changeme!" nusp "654321" department "MAC" and email "gold@bob.bob"

	Scenario: Anyone trying to see detailed information
		Given I'm at the "professors" page
		Then I should see "ACESSO NEGADO"

	Scenario: Admin seeing detailed information
		When I'm at the login page
		And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
  	When I fill the "Email" field with "kazuo@ime.usp.br"
  	And I fill the "Senha" field with "admin123"
  	And I press the "Entrar" button
		And I'm at the "professors" page
		And I click the "Bob" link
		Then I should see "Nome Completo: Bob"
		And I should see "Nível de acesso: Membro da comissão de monitoria"

	#Scenario: Professor does not exist
		#When I'm at the "professors/1000" page
		#Then I should see "Bob"
		#And I should see "Gold"
