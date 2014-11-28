Feature: Edit Request for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to update my requests for teaching assistants

    Scenario: Valid professor editing a request
        Given there is an open semester "2014" "1"
        And I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0122" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Gerenciar pedidos de monitoria"
        And I click the "Gerenciar pedidos de monitoria" link
        And I should see "MAC0110"
        And I click the "Ver" link
        And I click the "Editar" link
        And I should see "Edição de Pedido por Monitor"
        And I select "MAC0122 - Coisas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "12"
        And I select the priority option "Imprescindível"
        And I mark the "Atendimento aos alunos" checkbox
        And I unmark the "Correção de trabalhos" checkbox
        And I unmark the "Fiscalização de provas" checkbox
        And I write on the "Observações" text area "teste observações"
        And I press the "Enviar" button
        Then I should see "Pedido de Monitoria atualizado com sucesso."
        And I should see "Disciplina: MAC0122 - Coisas"
        And I should see "Número de monitores solicitados: 12"
        And I should see "Prioridade: Imprescindível"
        And I should see "Atendimento aos alunos: Sim"
        And I should see "Correção de trabalhos: Não"
        And I should see "Fiscalização de provas: Não"
        And I should see "Observações: teste observações"
