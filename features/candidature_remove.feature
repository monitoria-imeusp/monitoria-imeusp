Feature: Deleting a candidature
    In order to delete a candidature
    As a student
    I want do delete a candidature

    Background:
        When there is an open semester "2014" "1"

    @javascript
    Scenario: Student deleting a candidature
        Given I'm at the student login page
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And there is a course with name "ihc" and code "MAC0446" and department "MAC"
        And there is a course with name "concorrente" and code "MAC0438" and department "MAC"
        And there is an candidature with student "carlinhos" and first option "labxp" and second option "ihc" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        When I fill the "Número USP" field with "123456"
        And I fill the "Senha" field with "changeme!"
        And I press the "Entrar" button
        And I click the "Visualizar candidaturas" link
        And I click the "Mais informações" link
        And I click the "Remover" link
        And I should see "Você tem certeza?" in the alert
        And I confirm the alert
        Then I should not see "carlinhos"
