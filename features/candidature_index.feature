Feature: Candidature table visualization
    In order to see the candidatures
    As a superprofessor, admin, student or secretary
    I want to see the candidatures

    Background:
        When there is a department with code "MAC"
        And there is a department with code "MAT"
        And there is a department with code "MAE"
        And there is a student with name "Rogerio" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a student with name "Caio" and password "12345678" and nusp "123457" and gender "1" and rg "1234" and cpf "421" and address "matao2" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu2@usp.br" and has_bank_account "true"
        And there is a course with name "Cálculo I" and code "MAT0111" and department "MAT"
        And there is a course with name "Estatística Concorrente" and code "MAE0438" and department "MAE"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        And there is an candidature with student "Caio" and first option "Introdução à Ciência da Computação" and second option "Estatística Concorrente" and third option "" and availability for daytime "false" and availability for night time "true" and period preference "1" and transcript file "exemplo.pdf"

    Scenario: Admin seeing all candidatures
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        When I fill the "Email" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
		And I should see "MAT0111 - Cálculo I"
		And I should see "MAC0110 - Introdução à Ciência da Computação"
        Then I should see "Caio"
        And I should see "MAE0438 - Estatística Concorrente"
		And I should see "Ver"
		And I should not see "Nova Candidatura"

    Scenario: Hiperprofessor seeing all candidatures
        Given I'm at the professor login page
        And there is a hiper_professor with name "zara" and password "12345678" nusp "2222222" department "MAE" and email "zara@usp.br"
        When I fill the "Número USP" field with "2222222"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
        Then I should see "Rogerio"
        And I should see "MAT0111 - Cálculo I"
        And I should see "MAC0110 - Introdução à Ciência da Computação"
        Then I should see "Caio"
        And I should see "MAE0438 - Estatística Concorrente"
        And I should see "Ver"
        And I should not see "Nova Candidatura"

    Scenario: Superprofessor seeing candidatures of his department
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
		And I should see "Ver"
		And I should not see "Nova Candidatura"

    Scenario: Secretary seeing all candidatures
        Given I'm at the secretary login page
        And there is a secretary with name "sec" and password "12345678" nusp "1111" and email "a@a.com"
        When I fill the "Número USP" field with "1111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
        And I should see "MAT0111 - Cálculo I"
        And I should see "MAC0110 - Introdução à Ciência da Computação"
        Then I should see "Caio"
        And I should see "MAE0438 - Estatística Concorrente"
		And I should see "Ver"


    Scenario: Student seeing candidatures
        Given I'm at the student login page
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
        And I should see "MAT0111 - Cálculo I"
        And I should see "MAC0110 - Introdução à Ciência da Computação"
        Then I should not see "Caio"
        And I should not see "MAE0438 - Estatística Concorrente"
		And I should see "Ver"
