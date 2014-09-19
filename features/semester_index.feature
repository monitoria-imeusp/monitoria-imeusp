Feature: Semester list visualization
    In order to manage the semesters
    As a secretary or admin
    I want to see all existing semesters

    Background:
        When there is a closed semester "2014" "1"
        And there is a closed semester "2015" "0"
        And there is an open semester "2015" "1"

    Scenario: Admin seeing all semesters
        Given I'm logged in as the admin
        When I'm at the "semesters" page
        Then I should see "2014/2 Fechado"
        And I should see "2015/1 Fechado"
        And I should see "2015/2 Aberto"

    Scenario: Secretary seeing all semesters
        Given I'm logged in as a secretary
        When I'm at the "semesters" page
        Then I should see "2014/2 Fechado"
        And I should see "2015/1 Fechado"
        And I should see "2015/2 Aberto"
