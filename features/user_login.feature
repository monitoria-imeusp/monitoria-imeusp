Feature: User logging in
	In order to login
	As student or professor
	I want to see the appropriate first-access pages and links.

	Background:
        Given there is a closed but active semester 2015/2
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        And there is a department with code "MAC"

    Scenario: Professor logging in for the first time
        Given I'm logged in for the first time as a professor
        Then I should not see "Perfil"
        And I should see "Common Professor"
        And I should not see "Pedidos de monitoria"
        And I should not see "Meus monitores"
        And I should see "Edição de Professor"
        
    Scenario: Professor logging in after registering
        Given I'm logged in as a professor
        Then I should see "Perfil"
        And I should see "Common Professor"
        And I should see "Pedidos de monitoria"
        And I should see "Meus monitores"
        And I should not see "Edição de Professor"
    
    Scenario: Student logging in for the first time
        Given I'm logged in for the first time as a student
        Then I should not see "Perfil"
        And I should see "Joao"
        And I should see "Cadastro de Aluno"
        And I should not see "Minhas candidaturas"
    
    Scenario: Student logging in after registering
        Given I'm logged in as a student
        Then I should see "Perfil"
        And I should see "Joao"
        And I should not see "Cadastro de Aluno"
        And I should see "Minhas candidaturas"
    
    Scenario: User logging in for the first time trying to access hidden paths
        Given I'm logged in for the first time as a student
        And there is a student with name "carlinhos" with nusp "123456" and email "eu@usp.br"
        Then I should not see "Perfil"
        And I should see "Joao"
        And I should see "Cadastro de Aluno"
        And I should not see "Minhas candidaturas"
        And I visit student "carlinhos"'s page
        Then I should see "ACESSO NEGADO"
