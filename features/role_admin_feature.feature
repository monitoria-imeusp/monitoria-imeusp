Feature: Accessing the page
    In order to create new professors
    As an administrator
    I want to access the create professors page

    Scenario: Create a new professor
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And I click the "Novo Professor" link
        And I fill the "Nome" field with "tanto faz"
        And I fill the "Número USP" field with "12345"
        And I select "MAC" on the "Departamento"
        And I fill the "Senha" field with "12345"
        And I fill the "Confirme a senha" field with "12345"
        And I fill the "Email" field with "email@email.com"
        And I press the "Cadastrar" button
        Then I should see "Nome: tanto faz"
        And I should see "Nusp: 12345"
        And I should see "Email: email@email.com"
        And I should see "Departamento: mac"
        And I should see "Senha 12345"
        And I should see "Editar"

    Scenario: Verify if non-admins can't create a professors
        Given I'm at the create_professors page
        Then I should see "Para continuar, faça login ou registre-se."
    
    Scenario: Verify if the admin can edit professors
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And There is a professor with email "email@email.com" and password "12345"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And I click the "Lista de Professores" link
        Then I should see "Editar"
    
    Scenario: Verify if other users can't edit professors
        Given I'm at the list_professors page
        And There is a professor with email "email@email.com" and password "12345"
        Then I should not see "Editar"
