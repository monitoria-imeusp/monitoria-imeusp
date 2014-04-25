Feature: Course creation
    In order to create a course
    As a superprofessor or admin
    I want to create a course

    Scenario: Admin creating a course
        Given I'm at the login page
        And There is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Password" field with "admin123"
        And I press the "Sign in" button
        And I click the "Nova Disciplina" link
        And I fill the "Nome da Disciplina" field with "proglin"
        And I fill the "Código da Disciplina" field with "mac0315"
        And I press the "Cadastrar" button
        Then I should see "Nome da Disciplina: proglin"
        And I should see "Código da Disciplina: mac0315"
        And I should see "Editar"

    Scenario: Super professor creating a course
        Given I'm at the professor login page
        And There is a super_professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And I click the "Nova Disciplina" link
        And I fill the "Nome da Disciplina" field with "proglin"
        And I fill the "Código da Disciplina" field with "mac0315"
        And I press the "Cadastrar" button
        Then I should see "Nome da Disciplina: proglin"
        And I should see "Código da Disciplina: mac0315"
        And I should see "Editar"
    
    Scenario: Professor cannot create a course
        Given I'm at the professor login page
        And There is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Nusp" field with "1111111"
        And I fill the "Password" field with "12345678"
        And I press the "Sign in" button
        And I should not see "Nova Disciplina"
        Then I try the create course URL
        Then I should see "Listando Disciplinas"

    Scenario: Any person trying to create a course
        Given I'm at the home page
        Then I try the create course URL
        Then I should see "Listando Disciplinas"