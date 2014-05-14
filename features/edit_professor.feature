Feature: Edit Professor
    In order to edit a professor
    As an administrator
    I want to edit a professor

    Scenario: Valid Admin editing a professor
        Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And I'm at the login page
        And I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        When I click the "Lista de Professores" link
        And I click the "Editar" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I select "MAE" on the "Departamento"
        And I fill the "E-mail" field with "gold@troll.com"
        And I mark the "Permissão SuperProfessor" checkbox
        And I press the "Salvar" button
        Then I should see "Nome: Gold"
        And I should see "Número USP: 12345"
        And I should see "E-mail: gold@troll.com"
        And I should see "Departamento: MAE"
        And I should see "SuperProfessor: Sim"

    Scenario: Valid Admin editing a professor and changing the password
        Given there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And I'm at the login page
        And I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        When I click the "Lista de Professores" link
        And I click the "Editar" link
        And I fill the "Nome" field with "Gold"
        And I fill the "Número USP" field with "12345"
        And I select "MAE" on the "Departamento"
        And I fill the "E-mail" field with "gold@troll.com"
        And I fill the "Senha" field with "00000000"
        And I fill the "Confirme a senha" field with "00000000"
        And I mark the "Permissão SuperProfessor" checkbox
        And I press the "Salvar" button
        And I click the "Logout" link
        And I click the "Login Professor" link
        And I fill the "Número USP" field with "12345"
        And I fill the "Senha" field with "00000000"
        And I press the "Entrar" button
        Then I should see "Login efetuado com sucesso."
