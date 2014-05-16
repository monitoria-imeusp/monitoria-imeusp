Feature: Secretary edit
    In order to edit a secretary
    As an admin
    I want to edit a secretary

    Scenario: Admin editing a secretary
    	Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And There is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        And I click the "Lista de Secretárias" link
        And I click the "Editar" link
        And I fill the "Número USP" field with "2222222"
        And I fill the "Nome" field with "João"
        And I fill the "Email" field with "joao@ime.usp.br"
        And I fill the "Senha" field with "87654321"
        And I press the "Salvar" button
        Then I should see "Secretária foi atualizada com sucesso."
        And I should see "Número USP: 2222222"
        And I should see "Nome: João"
        And I should see "Email: joao@ime.usp.br"
        And I should see "Editar"

    Scenario: Professor cannot edit a secretary
        Given I'm at the professor login page
        And There is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And There is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        And I click the "Lista de Secretárias" link
        And I should not see "Editar"

    Scenario: Any person trying to edit a secretary
        Given I'm at the home page
        And There is a secretary with name "Marcia" and password "12345678" nusp "1111111" and email "marcia@ime.usp.br"
        And I click the "Lista de Secretárias" link
        And I should not see "Editar"