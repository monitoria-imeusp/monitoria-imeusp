Feature: Assistant roles table visualization
    In order to manage the assistant roles
    As a superprofessor or secretary
    I want to see the list of all assistant roles

    Background:
        When there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a department with code "MAT"
        And there is a course with name "Introdução à Ciência da Computação" and code "MAC0110" and department "MAC"
        And there is a course with name "Laboratório de programação eXtrema" and code "MAC0431" and department "MAC"
        And there is a course with name "Algebra II" and code "MAT0125" and department "MAT"
        And there is a student with name "Bob" with nusp "123456" and email "aluno@usp.br"
        And there is a student with name "John" with nusp "123457" and email "john@usp.br"
        And there is a student with name "Wil" with nusp "11112" and email "wil@usp.br"
        And there is a student with name "Mary" with nusp "22221" and email "mary@usp.br"
        And there is a student with name "Alfredo" with nusp "666" and email "alfredinho@usp.br"
        And there is a student with name "Jude" with nusp "555" and email "jude@usp.br"
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a professor with name "Gold" and nusp "87777" and department "MAC" and email "golddev@ime.usp.br"
        And there is a professor with name "Silver" and nusp "77778" and department "MAT" and email "silver@ime.usp.br"
        And there is a super_professor with name "Nina" and nusp "99987" and department "MAC" and email "ninadev@ime.usp.br"
        And there is a super_professor with name "Eloi" and nusp "78546" and department "MAT" and email "eloidev@ime.usp.br"
        And there is a hiper_professor with name "Zara" and password "changeme!" nusp "99986" department "MAT" and email "zaradev@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a request for teaching assistant by professor "Gold" for the course "MAC0431"
        And there is a request for teaching assistant by professor "Silver" for the course "MAT0125"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"
        And there is an assistant role for student "John" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Wil" with professor "Gold" at course "MAC0431"
        And there is an assistant role for student "Mary" with professor "Silver" at course "MAT0125"
        And there is an assistant role for student "Jude" with professor "Gold" at course "MAC0431"
        And there is a deactivated assistant role for student "Alfredo" with professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "3" with presence "false" for student "Bob" and professor "Dude" at course "MAC0110"
        And there is an assistant frequency with month "4" with presence "true" for student "Bob" and professor "Dude" at course "MAC0110"
        And there is an assistant frequency with month "5" with presence "true" for student "Bob" and professor "Dude" at course "MAC0110"        
        And there is an assistant frequency with month "3" with presence "true" for student "John" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "false" for student "John" and professor "Gold" at course "MAC0431"        
        And there is an assistant frequency with month "3" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "4" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "5" with presence "true" for student "Wil" and professor "Gold" at course "MAC0431"
        And there is an assistant frequency with month "3" with presence "false" for student "Mary" and professor "Silver" at course "MAT0125"
        And there is an assistant frequency with month "4" with presence "true" for student "Alfredo" and professor "Gold" at course "MAC0431"

    Scenario: Super professor sees his department assistant roles
        Given it's currently month 5
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
        And I should not see "Mary"
        And I should not see "MAT0125"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And I'm back to current time

    Scenario: Secretary sees all assistant roles
        Given it's currently month 5
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "MAC0110"
        And I should see "Mary"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And "Mary" should appear before "Wil"
        And I'm back to current time

    Scenario: Hiperprofessor sees all assistant roles
        Given it's currently month 5
        Given I'm logged in as professor "Zara"
        And I visit the assistant roles page
        Then I should see "Bob"
        And I should see "Dude"
        And I should see "Mary"
        And "Bob" should appear before "John"
        And "John" should appear before "Wil"
        And "Alfredo" should appear before "Bob"
        And "Jude" should appear before "Wil"
        And "John" should appear before "Jude"
        And "Mary" should appear before "Wil"
        And I'm back to current time

    Scenario: Common professor cannot see all assistant roles
        Given I'm logged in as a professor
        And I visit the assistant roles page
        Then I should see "ACESSO NEGADO"

    Scenario: Secretary sees the correct frequencies
        Given it's currently month 5
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        Then I should see "Bob MAC0110 Dude Desativar Atestado • Março: Ausente • Abril: Presente • Maio: Presente"
        Then I should see "John MAC0431 Gold Desativar Atestado • Março: Presente • Abril: Ausente • Maio: Pendente"
        Then I should see "Wil MAC0431 Gold Desativar Atestado • Março: Presente • Abril: Presente • Maio: Presente"
        Then I should see "Mary MAT0125 Silver Desativar Atestado • Março: Ausente • Abril: Pendente • Maio: Pendente"
        Then I should see "Jude MAC0431 Gold Desativar Atestado • Março: Pendente • Abril: Pendente • Maio: Pendente"
        Then I should see "Alfredo MAC0431 Gold Desativado Atestado • Março: --- • Abril: Presente • Maio: ---"
        And I should not see "Junho"
        Then I'm back to current time

    Scenario: Super professor sees the correct frequencies
        Given it's currently month 5
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        Then I should see "Bob MAC0110 Dude Ativo • Março: Ausente • Abril: Presente • Maio: Presente"
        Then I should see "John MAC0431 Gold Ativo • Março: Presente • Abril: Ausente • Maio: Marcar presença Marcar ausência"
        Then I should see "Wil MAC0431 Gold Ativo • Março: Presente • Abril: Presente • Maio: Presente"
        Then I should see "Jude MAC0431 Gold Ativo • Março: Marcar presença Marcar ausência • Abril: Marcar presença Marcar ausência • Maio: Marcar presença Marcar ausência"
        Then I should see "Alfredo MAC0431 Gold Desativado • Março: --- • Abril: Presente • Maio: ---"
        And I should not see "Junho"
        Then I'm back to current time

    Scenario: Super professor marks frequency
        Given it's currently month 5
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        And I click the first "Marcar presença" link
        Then I should see "Bob MAC0110 Dude Ativo • Março: Ausente • Abril: Presente • Maio: Presente"
        Then I should see "John MAC0431 Gold Ativo • Março: Presente • Abril: Ausente • Maio: Presente"
        Then I should see "Wil MAC0431 Gold Ativo • Março: Presente • Abril: Presente • Maio: Presente"
        Then I should see "Jude MAC0431 Gold Ativo • Março: Marcar presença Marcar ausência • Abril: Marcar presença Marcar ausência • Maio: Marcar presença Marcar ausência"
        Then I should see "Alfredo MAC0431 Gold Desativado • Março: --- • Abril: Presente • Maio: ---"
        And I click the first "Marcar ausência" link
        Then I should see "Bob MAC0110 Dude Ativo • Março: Ausente • Abril: Presente • Maio: Presente"
        Then I should see "John MAC0431 Gold Ativo • Março: Presente • Abril: Ausente • Maio: Presente"
        Then I should see "Wil MAC0431 Gold Ativo • Março: Presente • Abril: Presente • Maio: Presente"
        Then I should see "Jude MAC0431 Gold Ativo • Março: Ausente • Abril: Marcar presença Marcar ausência • Maio: Marcar presença Marcar ausência"
        Then I should see "Alfredo MAC0431 Gold Desativado • Março: --- • Abril: Presente • Maio: ---"
        And I should not see "Junho"
        Then I'm back to current time

    Scenario: Secretary pays assistant roles for last month
        Given it's currently month 5
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        And I click the "Pagar monitores" link
        Then I should see "Bob MAC0110 Dude Desativar Atestado • Março: Ausente • Abril: Pago • Maio: Presente"
        Then I should see "John MAC0431 Gold Desativar Atestado • Março: Presente • Abril: Ausente • Maio: Pendente"
        Then I should see "Wil MAC0431 Gold Desativar Atestado • Março: Presente • Abril: Pago • Maio: Presente"
        Then I should see "Mary MAT0125 Silver Desativar Atestado • Março: Ausente • Abril: Pendente • Maio: Pendente"
        Then I should see "Jude MAC0431 Gold Desativar Atestado • Março: Pendente • Abril: Pendente • Maio: Pendente"
        Then I should see "Alfredo MAC0431 Gold Desativado Atestado • Março: --- • Abril: Pago • Maio: ---"
        And I should not see "Junho"
        Then I'm back to current time



    @javascript
    Scenario: Secretary filters roles
        Given it's currently month 5
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        And I select the department option "MAC"
        Then I should see "Bob"
        And I should see "John"
        And I should see "Wil"
        And I should not see "Mary"
        Then I select the department option "MAT"
        Then I should see "Mary"
        And I should not see "Bob"
        And I should not see "John"
        And I should not see "Wil"
        Then I select the department option "ALL"
        Then I should see "Mary"
        And I should see "Bob"
        And I should see "John"
        And I should see "Wil"
        Then I select "Abril" on the "month_select"
        Then I select "Presentes" on the "status_select"
        Then I should see "Bob"
        And I should see "Wil"
        And I should not see "John"
        And I should not see "Mary"
        Then I select "Ausentes" on the "status_select"
        Then I should see "John"
        And I should not see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        Then I select "Pendentes" on the "status_select"
        Then I should see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I select "Março" on the "month_select"
        Then I should not see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I'm back to current time

    @javascript
    Scenario: Hiper professor filters roles
        Given it's currently month 5
        Given I'm logged in as professor "Zara"
        And I visit the assistant roles page
        And I select the department option "MAC"
        Then I should see "Bob"
        And I should see "John"
        And I should see "Wil"
        And I should not see "Mary"
        Then I select the department option "MAT"
        Then I should see "Mary"
        And I should not see "Bob"
        And I should not see "John"
        And I should not see "Wil"
        Then I select the department option "ALL"
        Then I should see "Mary"
        And I should see "Bob"
        And I should see "John"
        And I should see "Wil"
        Then I select "Abril" on the "month_select"
        Then I select "Presentes" on the "status_select"
        Then I should see "Bob"
        And I should see "Wil"
        And I should not see "John"
        And I should not see "Mary"
        Then I select "Ausentes" on the "status_select"
        Then I should see "John"
        And I should not see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        Then I select "Pendentes" on the "status_select"
        Then I should see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I select "Março" on the "month_select"
        Then I should not see "Mary"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I'm back to current time

    @javascript
    Scenario: Super professor filters roles
        Given it's currently month 5
        Given I'm logged in as a super professor
        And I visit the assistant roles page
        Then I select "Abril" on the "month_select"
        Then I select "Presentes" on the "status_select"
        Then I should see "Bob"
        And I should see "Wil"
        And I should not see "John"
        Then I select "Ausentes" on the "status_select"
        Then I should see "John"
        And I should not see "Bob"
        And I should not see "Wil"
        Then I select "Pendentes" on the "status_select"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I select "Março" on the "month_select"
        And I should not see "Bob"
        And I should not see "Wil"
        And I should not see "John"
        Then I'm back to current time


    Scenario: Secretary requests assistant evaluations
        Given I'm ready to receive email
        Given I'm logged in as a secretary
        And I visit the assistant roles page
        And I click the "Pedir avaliações dos professores" link
        Then the assistant evaluation reminder email for semester "2" of year "2014" should have been delivered properly to "prof@ime.usp.br"
        And the assistant evaluation reminder email for semester "2" of year "2014" should have been delivered properly to "golddev@ime.usp.br"
        And the assistant evaluation reminder email for semester "2" of year "2014" should have been delivered properly to "silver@ime.usp.br"
        And I should see "Solicitações enviadas aos professores"
        
