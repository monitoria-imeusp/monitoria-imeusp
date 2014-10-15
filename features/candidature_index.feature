Feature: Candidature table visualization
    In order to see the candidatures
    As a superprofessor, admin, student or secretary
    I want to see the candidatures

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a department with code "MAT"
        And there is a department with code "MAE"
        And there is a student with name "Rogerio" with nusp "123456" and email "eu@usp.br"
        And there is a student with name "Caio" with nusp "123457" and email "eu2@usp.br"
        And there is a course with name "Cálculo I" and code "MAT0111" and department "MAT"
        And there is a course with name "Estatística Concorrente" and code "MAE0438" and department "MAE"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Estatística Concorrente" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        And there is an candidature with student "Caio" and first option "Introdução à Ciência da Computação" and second option "Estatística Concorrente" and third option "" and availability for daytime "false" and availability for night time "true" and period preference "1"

    Scenario: Admin seeing all candidature categories (by department)
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
        Then I should see "MAC"
        And I should see "MAE"
        And I should see "MAT"

    Scenario: Hiperprofessor seeing all candidature categories (by department)
        Given I'm at the professor login page
        And there is a hiper_professor with name "zara" and password "12345678" nusp "2222222" department "MAE" and email "zara@usp.br"
        When I fill the "Número USP" field with "2222222"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
        Then I should see "MAC"
        And I should see "MAE"
        And I should see "MAT"

    Scenario: Superprofessor seeing candidatures involving his department
        Given I'm at the professor login page
        And there is a super_professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Caio"
        And I should see "MAC0110 - Introdução à Ciência da Computação"
		And I should see "MAE0438 - Estatística Concorrente"
        Then I should not see "Rogerio"
        And I should not see "MAT0111 - Cálculo I"
		And I should see "Mais informações"
		And I should not see "Nova Candidatura"

    Scenario: Secretary seeing all candidatures
        Given I'm at the secretary login page
        And there is a secretary with name "sec" and password "12345678" nusp "1111" and email "a@a.com"
        When I fill the "Número USP" field with "1111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
        Then I should see "MAC"
        And I should see "MAE"
        And I should see "MAT"


    Scenario: Student seeing candidatures
        Given I'm at the student login page
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "2014/2"
        And I should see "MAT0111 - Cálculo I"
        And I should see "MAE0438 - Estatística Concorrente"
        And I should not see "MAC0110 - Introdução à Ciência da Computação"
		And I should see "Mais informações"
