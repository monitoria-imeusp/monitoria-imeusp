Feature: Create a candidature
	In order to create a candidature
	As a student
	I want to create a candidature

    Background:
        When there is an open semester "2014" "1"

	Scenario: Student creating a candidature
        Given I'm at the student login page
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And there is a course with name "ihc" and code "MAC0446" and department "MAC"
        And there is a course with name "concorrente" and code "MAC0438" and department "MAC"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I go to the new candidature form
		And I select "MAC0342 - labxp" on the "Curso: 1ª opção"
		And I select "MAC0438 - concorrente" on the "Curso: 2ª opção"
        And I mark the "Disponibilidade para trabalhar de dia" checkbox
        And I select the preference option "Diurno"
        And I write on the "Observações" text area "teste observações"
        And I press the "Enviar" button
        Then I should see "Candidatura criada com sucesso."
        And I should see "Aluno: carlinhos"
        And I should see "Curso: 1ª opção: MAC0342 - labxp"
        And I should see "Curso: 2ª opção: MAC0438 - concorrente"
        And I should see "Disponibilidade para trabalhar de dia: Sim"
        And I should see "Disponibilidade para trabalhar de noite: Não"
        And I should see "Preferência de trabalhar no período: Diurno"
        And I should see "Observações: teste observações"

    Scenario: Student misses a field pattern
        Given I'm at the student login page
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And there is a course with name "ihc" and code "MAC0446" and department "MAC"
        And there is a course with name "concorrente" and code "MAC0438" and department "MAC"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I go to the new candidature form
		And I select "MAC0438 - concorrente" on the "Curso: 2ª opção"
        And I mark the "Disponibilidade para trabalhar de dia" checkbox
        And I select the preference option "Diurno"
        And I press the "Enviar" button
        Then I should not see "Candidatura criada com sucesso."

