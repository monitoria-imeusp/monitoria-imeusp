Feature: CRUD Request for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to create, read, update and delete my requests for teaching assistants

  Scenario: Valid professor creating a new request
    Given I'm at the professor login page
    And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
    And there is a department with code "MAC"
    And there is a course with name "Mascarenhas" and code "MAC0300" and department "MAC"
    When I fill the "Número USP" field with "123"
    And I fill the "Senha" field with "prof-123"
    And I press the "Entrar" button
    And I should see "Pedidos de Monitoria"
    And I click the "Pedidos de Monitoria" link
    And I should see "Novo pedido de monitor"
    And I click the "Novo pedido de monitor" link
    And I should see "Novo pedido de Monitoria"
    And I select "Mascarenhas" on the "Disciplina"
    And I fill the "Número de monitores solicitados" field with "2"
    And I select the priority option "Extremamente necessário, mas não imprescindível"
    And I mark the "Correção de trabalhos" checkbox
    And I mark the "Fiscalização de provas" checkbox
    And I write on the "Observações" text area "teste observações"
    And I press the "Enviar solicitação de monitor" button
    Then I should see "Pedido de Monitoria feito com sucesso"
    And I should see "Disciplina: Mascarenhas"
    And I should see "Número de monitores solicitados: 2"
    And I should see "Prioridade: Extremamente necessário, mas não imprescindível"
    And I should see "Atendimento aos alunos: Não"
    And I should see "Correção de trabalhos: Sim"
    And I should see "Fiscalização de provas: Sim"
    And I should see "Observações: teste observações"

    Scenario: Valid professor editing a request
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAC"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0122" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        And I click the "Pedidos de Monitoria" link
        And I should see "MAC0110"
        And I click the "Ver" link
        And I click the "Editar" link
        And I should see "Editando Pedido de Monitoria"
        And I select "Coisas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "12"
        And I select the priority option "Imprescindível"
        And I mark the "Atendimento aos alunos" checkbox
        And I unmark the "Correção de trabalhos" checkbox
        And I unmark the "Fiscalização de provas" checkbox
        And I write on the "Observações" text area "teste observações"
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Pedido de Monitoria atualizado com sucesso."
        And I should see "Disciplina: Coisas"
        And I should see "Número de monitores solicitados: 12"
        And I should see "Prioridade: Imprescindível"
        And I should see "Atendimento aos alunos: Sim"
        And I should see "Correção de trabalhos: Não"
        And I should see "Fiscalização de provas: Não"
        And I should see "Observações: teste observações"

    Scenario: A professor can't see the request of another professor
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Mandel" and password "prof-123" nusp "1234" department "MAC" and email "kira@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a course with name "Coisas" and code "MAC0122" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Mandel" and course "MAC0122" and requested_number "2" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        Then I click the "Pedidos de Monitoria" link
        And I should see "MAC0110"
        And I should not see "MAC0122"

    Scenario: Invalid Course
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        And I click the "Pedidos de Monitoria" link
        And I click the "Novo pedido de monitor" link
        And I fill the "Número de monitores solicitados" field with "2"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Selecione uma disciplina"

    Scenario: Empty number of teaching assistants
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAC"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        And I click the "Pedidos de Monitoria" link
        And I click the "Novo pedido de monitor" link
        And I select "Mascarenhas" on the "Disciplina"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Peça pelo menos um monitor"


    Scenario: Zero or less teaching assistants
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAC"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        And I click the "Pedidos de Monitoria" link
        And I click the "Novo pedido de monitor" link
        And I select "Mascarenhas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "0"
        And I select the priority option "Extremamente necessário, mas não imprescindível"
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Peça pelo menos um monitor"
        And I fill the "Número de monitores solicitados" field with "-2"
        And I press the "Enviar solicitação de monitor" button
        And I should see "Peça pelo menos um monitor"

    Scenario: Without priority
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a department with code "MAC"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        And I click the "Pedidos de Monitoria" link
        And I click the "Novo pedido de monitor" link
        And I select "Mascarenhas" on the "Disciplina"
        And I fill the "Número de monitores solicitados" field with "3"
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Escolha uma prioridade"

    Scenario: Check request assistant table
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        Then I click the "Pedidos de Monitoria" link
        And I should see "MAC0110"
        And I should see "1"
        And I click the "Ver" link
        And I should see "Atendimento aos alunos: Não"
        And I should see "Correção de trabalhos: Sim"
        And I should see "Fiscalização de provas: Sim"

    @javascript
    Scenario: Valid professor deleting a request
        Given I'm at the professor login page
        And there is a department with code "MAC"
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a course with name "Mascarenhas" and code "MAC0110" and department "MAC"
        And there is a request for teaching assistant with professor "Bob" and course "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Número USP" field with "123"
        And I fill the "Senha" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de Monitoria"
        Then I click the "Pedidos de Monitoria" link
        And I click the "Ver" link
        And I click the "Remover" link
        And I should see "Você tem certeza?" in the alert
        And I confirm the alert
        Then I should not see "MAC0122"
