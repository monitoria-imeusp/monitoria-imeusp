Feature: Seeing an advise
	In order to see the advises
	As anyone
	I want to be sure I can see the advises
    
  Background:
      Given there is a closed but active semester 2015/2

	Scenario: Anyone can see advises
		Given there is an advise with title "Aviso 1" and message "Teste1" and urgency "false"
		When I'm at the home page
		Then I should see "Aviso 1"
		And I should see "Teste1"