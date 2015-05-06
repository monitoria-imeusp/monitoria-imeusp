Feature: Upddating a candidature
	In order to update a candidature
	As a student
	I want to update a candidature

    Background:
        When there is an open semester "2014" "1"
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And there is a course with name "ihc" and code "MAC0446" and department "MAC"
        And there is a course with name "concorrente" and code "MAC0438" and department "MAC"
        And there is an candidature with student "carlinhos" and first option "labxp" and second option "ihc" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"

	Scenario: Student editing a candidature
        Given I'm at the user login page
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        And I click the "Minhas candidaturas" link
        And I click the "Mais informações" link
        And I click the "Editar" link
		And I select "MAC0342 - labxp" on the "Curso: 1ª opção"
		And I select "MAC0438 - concorrente" on the "Curso: 2ª opção"
        And I mark the "Disponibilidade para trabalhar de dia" checkbox
        And I mark the "Aceita ser monitor voluntário (sem bolsa)" checkbox
        And I select the preference option "Diurno"
        And I write on the "Observações" text area "teste observações"
        And I press the "Enviar" button
        Then I should see "Candidatura atualizada com sucesso."
        And I should see "Aluno: carlinhos"
        And I should see "Curso: 1ª opção: MAC0342 - labxp"
        And I should see "Curso: 2ª opção: MAC0438 - concorrente"
        And I should see "Disponibilidade para trabalhar de dia: Sim"
        And I should see "Disponibilidade para trabalhar de noite: Não"
        And I should see "Preferência de trabalhar no período: Diurno"
        And I should see "Aceita ser monitor voluntário (sem bolsa): Sim"
        And I should see "Observações: teste observações"

    Scenario: Student misses a field pattern
        Given I'm at the user login page
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        And I click the "Minhas candidaturas" link
        And I click the "Mais informações" link
        And I click the "Editar" link
		And I select "MAC0438 - concorrente" on the "Curso: 2ª opção"
        And I mark the "Disponibilidade para trabalhar de dia" checkbox
        And I select the preference option "Diurno"
        And I press the "Enviar" button
        Then I should not see "Candidatura criada com sucesso."
