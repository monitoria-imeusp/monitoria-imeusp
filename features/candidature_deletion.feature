Feature: Deleting a candidature
	In order to delete a candidature
	As a student
	I want do delete a candidature

	@javascript
	Scenario: Student deleting a course
        Given I'm at the student login page
        And there is a student with name "carlinhos" and password "12345678" and nusp "123456" and gender "1" and rg "123" and cpf "321" and address "matao" and district "butanta" and zipcode "000" and city "sp" and state "sp" and tel "0123456789" and cel "1234567890" and email "eu@usp.br" and has_bank_account "true"
        And there is a course with name "labxp" and code "MAC0342"
        And there is a course with name "ihc" and code "MAC0446"
        And there is a course with name "concorrente" and code "MAC0438"
        And there is an candidature with student "carlinhos" and first option "labxp" and second option "ihc" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "12345678"
        And I press the "Entrar" button
        And I click the "Candidaturas" link
        And I click the "Deletar" link
        And I should see "Você tem certeza?" in the alert
        And I confirm the alert
        Then I should not see "carlinhos"