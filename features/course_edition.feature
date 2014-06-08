Feature: Course edit
    In order to edit a course
    As a superprofessor or admin
    I want to edit a course

    Scenario: Admin editing a course
    	Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a department with code "MAC"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I click the "Disciplinas" link
        And I click the "MAC0342" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "MAC342"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: MAC342"

    Scenario: Super professor editing a course
        Given I'm at the professor login page
        And there is a super_professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Disciplinas" link
        And I click the "MAC0342" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "MAC0342"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: MAC0342"

    Scenario: Professor cannot edit a course
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Disciplinas" link
        And I should not see "Editar"

    Scenario: Any person trying to edit a course
        Given I'm at the home page
        When I click the "Disciplinas" link
        Then I should not see "Editar"
