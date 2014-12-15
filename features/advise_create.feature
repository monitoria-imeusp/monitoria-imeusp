Feature: Adding new messages
	In order to post new messages
	As a secretary
	I want to write new messages

	Scenario: Secretary creating an advise
		Given I'm logged in as a secretary
		And I click the "Adicionar aviso" link
		And I fill the "Título" field with "Aviso 1"
		And I fill the "Texto" field with "Teste 1"
		And I mark the "Mensagem Importante" checkbox
		And I press the "Publicar Mensagem." button
		Then I should see "Aviso 1"
		And I should see "Teste 1"

	Scenario: Professor can't create an advise
		Given there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
		Then I'm at the professor login page
        When I'm ready to receive email
        And I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        Then I should not see "Adicionar aviso"

    Scenario: Student can't create an advise
    	Given I'm logged in as a student
    	Then I should not see "Adicionar aviso"

    Scenario: Stranger can't create an advise
    	Given I'm at the home page
    	Then I should not see "Adicionar aviso"