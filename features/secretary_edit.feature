Feature: Secretary edit
    In order to edit a secretary
    As an admin
    I want to edit a secretary

    Background: 
        Given there is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"

    Scenario: Admin can not edit a secretary
    	Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Funcionários" link
        And I click the "Marcia" link
        And I should not see "Editar"
        And I should see "Remover"

    Scenario: Professor cannot edit a secretary
        Given I'm at the professor login page
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Funcionários" link
        And I click the "Marcia" link
        And I should not see "Editar"
        And I should not see "Remover"

    Scenario: Any person trying to edit a secretary
        Given I'm at the home page
        And I click the "Funcionários" link
        And I click the "Marcia" link
        And I should not see "Editar"
        And I should not see "Remover"

    Scenario: Secretary edits itself
        Given I'm at the secretary login page
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        Then I should see "Meu Perfil"
        And I click the "Meu Perfil" link
        Then I should see "Editar"
        And I click the "Editar" link
        And I fill the "Número USP" field with "2222222"
        And I fill the "Nome" field with "João"
        And I fill the "Email" field with "joao@ime.usp.br"
        And I fill the "Senha" field with "87654321"
        And I fill the "Confirme a senha" field with "87654321"
        And I press the "Enviar" button
        Then I should see "Funcionário(a) foi atualizado(a) com sucesso."
        And I should see "Número USP: 2222222"
        And I should see "Nome: João"
        And I should see "Email: joao@ime.usp.br"
