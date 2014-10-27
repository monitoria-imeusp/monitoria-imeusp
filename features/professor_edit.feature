Feature: Edit Professor
    In order to edit a professor
    As an administrator
    I want to edit a professor

    Background:
        Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAE"

    Scenario: Admin can not edit a professor
        Given I'm at the login page
        And I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        When I click the "Professores" link
        And I click the "Bob" link
        And I should not see "Editar"

    Scenario: Professor editing itself
        Then I'm at the professor login page
        When I'm ready to receive email
        And I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        When I click the "Meu Perfil" link
        And I click the "Editar" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I select "MAE" on the "Departamento"
        And I fill the "Email" field with "gold@troll.com"
        And I press the "Enviar" button
        And I click the "Sair" link
        And I confirm the professor edition with nusp "12345" and password "prof-123" and email "gold@troll.com" and sign in
        And I click the "Meu Perfil" link
        Then I should see "Nome: Gold"
        Then I should see "Número USP: 12345"
        Then I should see "Email: gold@troll.com"
        Then I should see "Departamento: MAE"

    Scenario: Super-professor can't give super-professor authorization
        Given there is a super_professor with name "Nina" and password "changeme!" nusp "321" department "MAE" and email "nin@nin.nin"
        Given I'm at the professor login page
        And I fill the "Número USP" field with "321"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        When I click the "Professores" link
        And I click the "Bob" link
        Then I should not see "Privilégios" 

    Scenario:Hiper-professor giving super-professor authorization
        Given there is a hiper_professor with name "Zara" and password "changeme!" nusp "321" department "MAT" and email "zar@zar.zar"
        Given I'm at the professor login page
        And I fill the "Número USP" field with "321"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        When I click the "Professores" link
        And I click the "Bob" link
        And I press the "Privilégios" button
        Then I should see "Bob é agora um Super-professor" 