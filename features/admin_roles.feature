Feature: Accessing the page
    In order to create new professors
    As an administrator
    I want to access the create professors page
    
    Background:
        Given there is a closed but active semester 2015/2

    Scenario: Verify if non-admins can't create a professors
        Given I'm at the create_professors page
        Then I should see "ACESSO NEGADO"

    Scenario: Verify if the admin can't edit professors
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I'm at the list_professors page
        And I click the "mqz" link
        Then I should not see "Editar"

    Scenario: Verify if other users can't edit professors
        Given I'm at the list_professors page
        And there is a professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        Then I should not see "Editar"
