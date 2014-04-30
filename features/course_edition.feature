Feature: Course edit
    In order to edit a course
    As a superprofessor or admin
    I want to edit a course

    Scenario: Admin editing a course
    	Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And There is a course with name "labxp" and code "mac0342"
        And I click the "Lista de Disciplina" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "mac342"
        And I press the "Salvar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: mac342"

    Scenario: Super professor editing a course
        Given I'm at the professor login page
        And There is a super_professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And There is a course with name "labxp" and code "mac0342"
        And I click the "Lista de Disciplina" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "mac342"
        And I press the "Salvar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: mac342"