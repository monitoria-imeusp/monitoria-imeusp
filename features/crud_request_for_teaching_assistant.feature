Feature: CRUD Request for Teaching Assistant
  In order to manage requests for teaching assistant
  As a professor
  I want to create, read, update and delete my requests for teaching assistants

  Scenario: Valid professor creating a new request
    Given I'm at the professor login page
    And there is a professor with name "Bob" and password "prof-123" nusp "123" department "MAC" and email "bob@bob.bob"
    When I fill the "Nusp" field with "123"
    And I fill the "Password" field with "prof-123"
    And I press the "Sign in" button
    And I should see "Pedidos de monitoria"
    And I click the "Pedidos de monitoria" link
    And I should see "Novo pedido de monitor"
    And I click the "Novo pedido de monitor" link
    And I should see "Novo pedido de Monitoria"
    And I fill the "Disciplina" field with "MAC0300"
    And I fill the "Número de monitores solicitados" field with "2"
    And I select the " Extremamente necessário, mas não imprescindível " option
    And I mark the "Correção de trabalhos" checkbox
    And I mark the "Fiscalização de provas" checkbox
    And I press the "Enviar solicitação de monitor" button
    Then I should see "Request for teaching assistant was successfully created"
    And I should see "Disciplina: MAC0300"
    And I should see "Número de monitores solicitados: 2"
    And I should see "Prioridade: Extremamente necessário, mas não imprescindível"
    And I should see "Atendimento aos alunos: false"
    And I should see "Correção de trabalhos: true"
    And I should see "Fiscalização de provas: true"