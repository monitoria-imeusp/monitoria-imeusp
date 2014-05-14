Feature: CRUD Request for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to create, read, update and delete my requests for teaching assistants

  Scenario: Valid professor creating a new request
    Given I'm at the professor login page
    And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
    When I fill the "Nusp" field with "123"
    And I fill the "Password" field with "prof-123"
    And I press the "Entrar" button
    And I should see "Pedidos de monitoria"
    And I click the "Pedidos de monitoria" link
    And I should see "Novo pedido de monitor"
    And I click the "Novo pedido de monitor" link
    And I should see "Novo pedido de Monitoria"
    And I fill the "Disciplina" field with "MAC0300"
    And I fill the "Número de monitores solicitados" field with "2"
    And I select the priority option "Extremamente necessário, mas não imprescindível"
    And I mark the "Correção de trabalhos" checkbox
    And I mark the "Fiscalização de provas" checkbox
    And I press the "Enviar solicitação de monitor" button
    Then I should see "Pedido de Monitoria feito com sucesso"
    And I should see "Disciplina: MAC0300"
    And I should see "Número de monitores solicitados: 2"
    And I should see "Prioridade: Extremamente necessário, mas não imprescindível"
    And I should see "Atendimento aos alunos: Não"
    And I should see "Correção de trabalhos: Sim"
    And I should see "Fiscalização de provas: Sim"

    Scenario: Valid professor editing a request
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a request for teaching assistant with professor "Bob" and subject "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Nusp" field with "123"
        And I fill the "Password" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        And I click the "Pedidos de monitoria" link
        And I should see "Editar"
        And I click the "Editar" link
        And I should see "Editando Pedido de Monitoria"
        And I fill the "Disciplina" field with "MAC0122"
        And I fill the "Número de monitores solicitados" field with "12"
        And I select the priority option "Imprescindível"
        And I mark the "Atendimento aos alunos" checkbox
        And I unmark the "Correção de trabalhos" checkbox
        And I unmark the "Fiscalização de provas" checkbox
        And I press the "Enviar solicitação de monitor" button
        Then I should see "Pedido de Monitoria atualizado com sucesso."
        And I should see "Disciplina: MAC0122"
        And I should see "Número de monitores solicitados: 12"
        And I should see "Prioridade: Imprescindível"
        And I should see "Atendimento aos alunos: Sim"
        And I should see "Correção de trabalhos: Não"
        And I should see "Fiscalização de provas: Não"

    @javascript
    Scenario: Valid professor deleting a request
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a request for teaching assistant with professor "Bob" and subject "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Nusp" field with "123"
        And I fill the "Password" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        And I click the "Pedidos de monitoria" link
        And I should see "Remover"
        And I click the "Remover" link
        And I confirm the alert
        Then I should not see "MAC0122"

    Scenario: A professor can't see the request of another professor
        Given I'm at the professor login page
        And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
        And there is a professor with name "Mandel" and password "prof-123" nusp "1234" department "MAC" and email "kira@bob.bob"
        And there is a request for teaching assistant with professor "Bob" and subject "MAC0110" and requested_number "4" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        And there is a request for teaching assistant with professor "Mandel" and subject "MAC0122" and requested_number "2" and priority "Extremamente necessário, mas não imprescindível" and student_assistance "false" and work_correction "true" and test_oversight "true"
        When I fill the "Nusp" field with "123"
        And I fill the "Password" field with "prof-123"
        And I press the "Entrar" button
        And I should see "Pedidos de monitoria"
        Then I click the "Pedidos de monitoria" link
        And I should see "MAC0110"
        And I should not see "MAC0122"

