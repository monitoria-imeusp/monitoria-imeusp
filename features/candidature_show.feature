Feature: Candidature visualization
    In order to see a candidature
    As a superprofessor or admin or student or secretary
    I want to see the candidature

    Scenario: Admin seeing a candidature
        Given I'm at the login page
        And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
        And there is a student with name "Rogerio" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
		And there is a course with name "Cálculo I" and code "MAT0111"
		And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        When I fill the "E-mail" field with "kazuo@ime.usp.br"
        And I fill the "Senha" field with "admin123"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
		And I should see "Cálculo I"
		And I should see "Introdução à Ciência da Computação"
		And I should see "Mostrar"
		And I should see "Editar"
		And I should see "Remover"
		And I should not see "Nova Candidatura"

    Scenario: Superprofessor seeing a candidature
        Given I'm at the professor login page
        And there is a super_professor with name "mandel" and password "12345678" nusp "1111111" department "MAC" and email "devil@usp.br"
        And there is a student with name "Rogerio" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a student with name "Caio" and password "12345678" and nusp "123457" and gender "1" and rg "1234" and cpf "421" and address "matao2" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu2@usp.br" and has_bank_account "true"
		And there is a course with name "Cálculo I" and code "MAT0111"
		And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110"
		And there is a course with name "Estatística Concorrente" and code "MAE0438"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
		And there is an candidature with student "Caio" and first option "Estatística Concorrente" and second option "Cálculo I" and third option "" and availability for daytime "false" and availability for night time "true" and period preference "1"
        When I fill the "Número USP" field with "1111111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
		And I should see "Cálculo I"
		And I should see "Caio"
		And I should see "Introdução à Ciência da Computação"
		And I should see "Mostrar"
		And I should see "Editar"
		And I should see "Remover"
		And I should not see "Nova Candidatura"
    
    Scenario: Secretary seeing a candidature
        Given I'm at the secretary login page
        And there is a secretary with name "sec" and password "12345678" nusp "1111" and email "a@a.com"
        And there is a student with name "Rogerio" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a student with name "Caio" and password "12345678" and nusp "123457" and gender "1" and rg "1234" and cpf "421" and address "matao2" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu2@usp.br" and has_bank_account "true"
		And there is a course with name "Cálculo I" and code "MAT0111"
		And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110"
		And there is a course with name "Estatística Concorrente" and code "MAE0438"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
		And there is an candidature with student "Caio" and first option "Estatística Concorrente" and second option "Cálculo I" and third option "" and availability for daytime "false" and availability for night time "true" and period preference "1"
        When I fill the "Número USP" field with "1111"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
        And I should see "Cálculo I"
		And I should see "Caio"
        And I should see "Introdução à Ciência da Computação"
		And I should see "Mostrar"
		And I should see "Editar"
		And I should see "Remover"
    
    Scenario: Student seeing a candidature
        Given I'm at the student login page
        And there is a student with name "Rogerio" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a student with name "Caio" and password "12345678" and nusp "123457" and gender "1" and rg "1234" and cpf "421" and address "matao2" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu2@usp.br" and has_bank_account "true"
		And there is a course with name "Cálculo I" and code "MAT0111"
		And there is a course with name "Estatística Concorrente" and code "MAC0110"
		And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110"
		And there is an candidature with student "Rogerio" and first option "Cálculo I" and second option "Introdução à Ciência da Computação" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
		And there is an candidature with student "Caio" and first option "Estatística Concorrente" and second option "Cálculo I" and third option "" and availability for daytime "false" and availability for night time "true" and period preference "1"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
		Then I should see "Rogerio"
        And I should see "Cálculo I"
		And I should not see "Caio"
        And I should not see "Estatística Concorrente"
		And I should see "Mostrar"
		And I should see "Editar"
		And I should see "Remover"
