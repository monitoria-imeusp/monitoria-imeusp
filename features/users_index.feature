Feature: Listing users
  In order to see all users
  As secretary or admin
  I want to see a list with all the users
    
  Background:
      Given there is a closed but active semester 2015/2
      And there is a professor with name "Bob" and nusp "123" and department "MAP" and email "robert@usp.br"
      And there is a student with name "Hong" with nusp "242424" and email "luquinhas@usp.br"
      And there is a user with name "Rafael" with nusp "987654" and email "rafao@usp.br"
      And there is a student_professor with name "Thomas" and password "password" and nusp "123456" and department "MAC" and email "carlin@usp.br"

  Scenario: Trying to list all users
      Given I'm at the login page
      And there is an admin user with email "kazuo@ime.usp.br" and password "admin123"
      When I fill the "Email" field with "kazuo@ime.usp.br"
      And I fill the "Senha" field with "admin123"
      And I press the "Entrar" button
      And I'm at the "users" page
      And I should see "Bob 123 professor"
      And I should see "Hong 242424 aluno"
      And I should see "Rafael 987654 usuário sem categoria"
      And I should see "Thomas 123456 aluno e professor"
