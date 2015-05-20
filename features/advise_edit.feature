Feature: Editing an advise
	In order to change the advises
	As a secretary
	I want to edit the current messages

	Background:
		Given there is an advise with title "Aviso 1" and message "Teste1" and urgency "false"

	Scenario: Secretary editing an advise
		Given I'm logged in as a secretary
		When I click the "Modificar" link
		And I fill the "Título" field with "Aviso 2"
		And I fill the "Texto" field with "Teste 2"
		And I press the "Publicar Mensagem." button
		Then I should see "Aviso 2"
		And I should see "Teste 2"

	Scenario: Professor can't edit an advise
        Given there is a department with code "MAC"
		And I'm logged in as a professor
        Then I should not see "Modificar"