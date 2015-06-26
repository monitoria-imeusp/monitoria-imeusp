Feature: Course creation
    In order to create a course
    As a superprofessor or admin
    I want to create a course

    @javascript
    Scenario: Admin creating a course
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a department with code "MAC"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Cadastrar disciplina" link
        And I fill the "Nome da Disciplina" field with "proglin"
        And I select "MAC" on the "Departamento"
        And I fill the "Código da Disciplina" field with "0315"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: proglin"
        And I should see "Código da Disciplina: MAC0315"
        And I should see "Editar"

    @javascript
    Scenario: Super professor creating a course
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And I'm logged in as super professor from the "MAC" department
        And I click the "Cadastrar disciplina" link
        And I fill the "Nome da Disciplina" field with "proglin"
        And I select "MAC" on the "Departamento"
        And I fill the "Código da Disciplina" field with "0315"
        And I press the "Enviar" button
        Then I should see "Nome da Disciplina: proglin"
        And I should see "Código da Disciplina: MAC0315"
        And I should see "Editar"

    Scenario: Professor cannot create a course
        Given there is a department with code "MAC"
        And I'm logged in as a professor
        And I should not see "Cadastrar disciplina"
        Then I try the create course URL
        Then I should see "ACESSO NEGADO"

    Scenario: Any person trying to create a course
        Given I'm at the home page
        Then I try the create course URL
        Then I should see "ACESSO NEGADO"
