Feature: Edit Professor
    In order to edit a professor
    As an administrator
    I want to edit a professor

    Background:
        Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "Bob" and password "prof-123" nusp "123456" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAE"

    Scenario: Admin can not edit a professor
        Given I'm at the login page
        And I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        When I'm at the list_professors page
        And I click the "Bob" link
        And I should not see "Editar"

    Scenario: Professor editing itself
        Given I'm logged in as a professor
        When I click the "Perfil" link
        And I click the second "Editar" link
        And I select "MAE" on the "Departamento"
        And I press the "Enviar" button
        Then I should see "Departamento: MAE"

    Scenario: Super-professor can't give super-professor authorization
        Given I'm logged in as a super professor
        When I'm at the list_professors page
        And I click the "Bob" link
        Then I should not see "Promover para comissão de monitoria"

    Scenario:Hiper-professor giving super-professor authorization
        Given I'm logged in as a hyper professor
        When I'm at the list_professors page
        And I click the "Bob" link
        And I press the "Promover para comissão de monitoria" button
        Then I should see "Bob é agora um Super-professor"