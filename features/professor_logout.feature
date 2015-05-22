Feature: Professor logout
    In order to leave the system
    As an professor
    I want to logout of the system

    Scenario: Successful Logout
        Given there is a department with code "MAC"
        And I'm logged in as a professor
        And I click the "Sair" link
        Then I should see "Sessão encerrada com sucesso."
