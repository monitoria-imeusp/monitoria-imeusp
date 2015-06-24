Feature: Deleting a candidature
    In order to delete a candidature
    As a student
    I want do delete a candidature

    Background:
        When there is an open semester "2014" "1"
        And I can do real web requests

    @javascript
    Scenario: Student deleting a candidature
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a department with code "MAC"
        And there is a course with name "labxp" and code "MAC0342" and department "MAC"
        And there is a course with name "ihc" and code "MAC0446" and department "MAC"
        And there is a course with name "concorrente" and code "MAC0438" and department "MAC"
        And there is an candidature with student "carlinhos" and first option "labxp" and second option "ihc" and third option "" and availability for daytime "true" and availability for night time "false" and period preference "2"
        And I'm logged in as student "carlinhos"
        And I click the "Minhas candidaturas" link
        And I click the "Mais informações" link
        And I click the "Remover" link
        And I should see "Você tem certeza?" in the alert
        And I confirm the alert
        Then I should see "Você não tem nenhuma candidatura"
