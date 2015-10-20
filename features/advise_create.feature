Feature: Adding new messages
	In order to post new messages
	As a secretary
	I want to write new messages
    
  Background:
      Given there is a closed but active semester 2015/2

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
        Given there is a department with code "MAC"
		Then I'm logged in as a professor
	    Then I should not see "Adicionar aviso"

	Scenario: Student can't create an advise
	  	Given I'm logged in as a student
	  	Then I should not see "Adicionar aviso"

	Scenario: Stranger can't create an advise
	  	Given I'm at the home page
	  	Then I should not see "Adicionar aviso"