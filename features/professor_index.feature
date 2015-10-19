Feature: Listing professors
	In order to see all professors
	As anyone
	I want to see a list with all the professors
    
  Background:
      Given there is a closed but active semester 2015/2

	Scenario: Trying to list all professors
		Given there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
		And there is a professor with name "Gold" and password "changeme!" nusp "321" department "MAC" and email "gold@bob.bob"
		When I'm at the "professors" page
		Then I should see "ACESSO NEGADO"
