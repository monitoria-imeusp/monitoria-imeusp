Feature: Creating Request for Teaching Assistant
    In order to create requests for teaching assistant
    As a professor
    I want to create requests for teaching assistants

    Background:
        Given there is an open semester "2014" "1"
        And there is a department with code "MAC"
        And there is a department with code "MAE"
        And there is a department with code "MAT"
        And there is a department with code "MAP"
        And there is a professor with name "Bob" and password "prof-123" nusp "123456" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0300" and department "MAC"
        And there is a course with name "Estocasticos" and code "MAE0238" and department "MAE"
        And there is a course with name "Algebra" and code "MAT0110" and department "MAT"
        And there is a course with name "Aplicacoes" and code "MAP0456" and department "MAP"    
        And I'm logged in as professor "Bob"
        And I should see "Pedidos de monitoria"
        And I go to the new request form

    Scenario: Valid professor creating a new request
        Then I should see "Novo Pedido por Monitor"
        And I select "MAC0300 - Mascarenhas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "2"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I mark the "Correção de trabalhos" checkbox
        And I mark the "Fiscalização de provas" checkbox
        And I write on the "Observações" text area "teste observações"
        And I press the "Enviar" button
        Then I should see "Pedido de Monitoria feito com sucesso"
        And I should see "Disciplina: MAC0300 - Mascarenhas"
        And I should see "Número de monitores solicitados: 2"
        And I should see "Prioridade: Extremamente necessário, mas não imprescindível"
        And I should see "Atendimento aos alunos: Não"
        And I should see "Correção de trabalhos: Sim"
        And I should see "Fiscalização de provas: Sim"
        And I should see "Observações: teste observações"

    @javascript
    Scenario: Invalid Course
        When I fill the "Número de monitores solicitados" field with "2"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar" button
        Then I should see "Disciplina não pode ficar em branco"


    Scenario: Empty number of teaching assistants
        When I select "MAC0300 - Mascarenhas" on the "Disciplina"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar" button
        Then I should see "Número de monitores solicitados não pode ficar em branco"

    Scenario: Zero or less teaching assistants
        When I select "MAC0300 - Mascarenhas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "0"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar" button
        Then I should see "Número de monitores solicitados não está incluído na lista"
        And I fill the "Número de monitores solicitados" field with "-2"
        And I press the "Enviar" button
        And I should see "Número de monitores solicitados não está incluído na lista"

    Scenario: Without priority
        When I select "MAC0300 - Mascarenhas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "3"
        And I press the "Enviar" button
        Then I should see "Prioridade"

    @javascript
    Scenario: Courses are sorted by department
        Then "Disciplina" should contain "MAC0300 - Mascarenhas"
        And "Disciplina" should contain "MAT0110 - Algebra"
        And "Disciplina" should contain "MAE0238 - Estocasticos"
        And "Disciplina" should contain "MAP0456 - Aplicacoes"
        And I select the department option "MAC"
        Then "Disciplina" should contain "MAC0300 - Mascarenhas"
        And "Disciplina" should not contain "MAT0110 - Algebra"
        And "Disciplina" should not contain "MAE0238 - Estocasticos"
        And "Disciplina" should not contain "MAP0456 - Aplicacoes"
        And I select the department option "MAE"
        Then "Disciplina" should not contain "MAC0300 - Mascarenhas"
        And "Disciplina" should not contain "MAT0110 - Algebra"
        And "Disciplina" should contain "MAE0238 - Estocasticos"
        And "Disciplina" should not contain "MAP0456 - Aplicacoes"
        And I select the department option "MAT"
        Then "Disciplina" should not contain "MAC0300 - Mascarenhas"
        And "Disciplina" should contain "MAT0110 - Algebra"
        And "Disciplina" should not contain "MAE0238 - Estocasticos"
        And "Disciplina" should not contain "MAP0456 - Aplicacoes"
        And I select the department option "MAP"
        Then "Disciplina" should not contain "MAC0300 - Mascarenhas"
        And "Disciplina" should not contain "MAT0110 - Algebra"
        And "Disciplina" should not contain "MAE0238 - Estocasticos"
        And "Disciplina" should contain "MAP0456 - Aplicacoes"
        And I select the department option "ALL"
        Then "Disciplina" should contain "MAC0300 - Mascarenhas"
        And "Disciplina" should contain "MAT0110 - Algebra"
        And "Disciplina" should contain "MAE0238 - Estocasticos"
        And "Disciplina" should contain "MAP0456 - Aplicacoes"

