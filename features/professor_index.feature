Feature: Listing professors
	In order to see all professors
	As anyone
	I want to see a list with all the professors

	Scenario: Listing all professors
		Given I'm at the home page
		And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
		And there is a professor with name "Gold" and password "changeme!" nusp "321" department "MAC" and email "gold@bob.bob"
		And I click the "Professores" link
		Then I should see "Bob"
		Then I should see "Gold"
