Feature: Course edit
    In order to edit a course
    As a superprofessor or admin
    I want to edit a course

    Background:
        Given there is a closed but active semester 2015/2

    Scenario: Admin editing a course
    	Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a department with code "MAC"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I go to the courses index
        And I click the "MAC0342" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "MAC342"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: MAC342"

    Scenario: Super professor editing a course
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I'm logged in as a super professor
        And I go to the courses index
        And I click the "MAC0342" link
        And I click the "Editar" link
        And I fill the "Nome da Disciplina" field with "labXp"
        And I fill the "Código da Disciplina" field with "MAC0342"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: labXp"
        And I should see "Código da Disciplina: MAC0342"

    Scenario: Professor cannot edit a course
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And I'm logged in as a professor
        And I go to the courses index
        And I should not see "Editar"

    Scenario: Any person trying to edit a course
        Given I'm at the home page
        When I go to the courses index
        Then I should not see "Editar"
