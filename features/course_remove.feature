Feature: Course deletion
	In order to delete a course
	As a superprofessor or admin
    I want to remove a course

    Scenario: Admin removing a course
    	Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And there is a course with name "labxp" and code "mac0342"
        And I click the "Lista de Disciplina" link
        And I click the "Remover" link
        And I should not see "labxp"
        And I should not see "mac0342"


    Scenario: Super professor removing a course
    	Given I'm at the professor login page
        And there is a super_professor with name "mqz" and password "12345678" nusp "1111111" department "MAC" and email "music@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a course with name "labxp" and code "mac0342"
        And I click the "Lista de Disciplina" link
        And I click the "Remover" link
        And I should not see "labxp"
        And I should not see "mac0342"

    Scenario: Professor cannot remove a course
        Given I'm at the professor login page
        And there is a professor with name "arnaldo" and password "12345678" nusp "1111111" department "MAC" and email "kira@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And there is a course with name "labxp" and code "mac0342"
        And I click the "Lista de Disciplina" link
        And I should not see "Remover"

    Scenario: Any person trying to remove a course
        Given I'm at the home page
        And I click the "Lista de Disciplina" link
        And I should not see "Remover"
