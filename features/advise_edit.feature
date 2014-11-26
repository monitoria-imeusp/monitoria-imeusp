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
		Given there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
		Then I'm at the professor login page
        When I'm ready to receive email
        And I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        Then I should not see "Modificar"