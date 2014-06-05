Feature: Candidature visualization
    In order to see a candidature
    As a superprofessor or admin or student or secretary
    I want to see the candidature

    Scenario: Admin seeing a candidature
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
		And there is a student with name "Rogerio"
		And there is a course with name "Cálculo I" and course code "MAT0111"
		And there is a course with name "Introdução à Ciência da Computação" and course code "MAC0110"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "yes" and availability for night time "no" and period preference "2"
        When I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogério"
		And I should see "Cálculo I"
		And I should see "Introdução à Ciência da Computação"
		And I should see "Visualizar"
		And I should see "Editar"
		And I should see "Remover"
		And I should not see "Nova Candidatura"

    Scenario: Superprofessor seeing a candidature
        Given I'm at the professor login page
        And there is a superprofessor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        And I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
		And there is a student with name "Rogerio"
		And there is a student with name "Caio"
		And there is a course with name "Cálculo I" and course code "MAT0111"
		And there is a course with name "Introdução à Ciência da Computação" and course code "MAC0110"
		And there is a course with name "Estatística Concorrente" and course code "MAE0438"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "yes" and availability for night time "no" and period preference "2"
		And there is an candidature with student "Caio" and first option "Estatística Concorrente" and second option "" and third option "" and availability for daytime "no" and availability for night time "yes" and period preference "1"
        And I click the "Candidaturas" link
		Then I should see "Rogério"
		And I should see "Cálculo I"
		And I should see "Introdução à Ciência da Computação"
		And I should see "Visualizar"
		And I should see "Editar"
		And I should see "Remover"
		And I should not see "Nova Candidatura"
