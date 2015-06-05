Feature: Login
    In order to manage the system
    As an administrator
    I want to login to the system

    Scenario: Valid credentials
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        Then I should see "Acesso efetuado com sucesso."

    Scenario: After exitting the page and entering it again
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I'm at the login page
        Then I should see "Avisos"
        And I should see "kazuo@ime.usp.br"
        And I should not see "Cadastrar Professor"
