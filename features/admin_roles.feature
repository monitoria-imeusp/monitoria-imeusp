Feature: Accessing the page
    In order to create new professors
    As an administrator
    I want to access the create professors page

    Scenario: Create a new professor
        Given I'm at the login page
        And there is a department with code "MAC"
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Novo Professor" link
        And I fill the "Nome" field with "tanto faz"
        And I fill the "Número USP" field with "12345"
        And I select "MAC" on the "Departamento"
        And I fill the "Senha" field with "12345678"
        And I fill the "Confirme a senha" field with "12345678"
        And I fill the "Email" field with "email@email.com"
        And I press the "Enviar" button
        Then I should see "Nome: tanto faz"
        And I should see "Número USP: 12345"
        And I should see "Email: email@email.com"
        And I should see "Departamento: MAC"
        And I should see "Editar"

    Scenario: Verify if non-admins can't create a professors
        Given I'm at the create_professors page
        Then I should see "Para continuar, faça login ou registre-se."

    Scenario: Verify if the admin can edit professors
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Professores" link
        And I click the "mqz" link
        Then I should see "Editar"

    Scenario: Verify if other users can't edit professors
        Given I'm at the list_professors page
        And there is a professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        Then I should not see "Editar"
