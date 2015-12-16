Feature: Late Requests for Teaching Assistant
	In order to manage requests for teaching assistante
	As an Admin
	I don't want normal professors to be able to make new requests for closed semesters
	And I want super and hiper professors to be able to make new requests for closed semesters

	Background:
		And there is a department with code "MAC"
        And there is a department with code "MAE"
		And there is a professor with name "Bob" and password "prof-123" nusp "12333" department "MAC" and email "bob@bob.bob"
        And there is a super_professor with name "Mandel" and password "prof-123" nusp "12344" department "MAC" and email "kira@bob.bob"
        And there is a hiper_professor with name "Claudia" and password "prof-123" nusp "12355" department "MAE" and email "claudia@ime.br"

    Scenario: Normal professor should see closed semester
    	Given there is a closed semester "2014" "1"
    	And I'm logged in as professor "Bob"
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should not see "Pedir monitor(es)"

    Scenario: Super professor should see closed semester
    	Given there is a closed semester "2014" "1"
    	And I'm logged in as professor "Mandel"
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should not see "Pedir monitor(es)"

	Scenario: Hiper professor should see closed semester
    	Given there is a closed semester "2014" "1"
        And I'm logged in as professor "Claudia"
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should not see "Pedir monitor(es)"