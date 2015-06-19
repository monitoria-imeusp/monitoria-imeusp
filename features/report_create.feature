Feature: Assistant role report creation
	In order to have assistant reports handled by the system
	As a student or secretary
	I want to have assistant role reports

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
        And there is a professor with name "Dude" and nusp "111111" and department "MAC" and email "prof@ime.usp.br"
        And there is a professor with name "Gold" and nusp "87777" and department "MAC" and email "golddev@ime.usp.br"
        And there is a professor with name "Silver" and nusp "77778" and department "MAT" and email "silver@ime.usp.br"
        And there is a super_professor with name "Nina" and nusp "99987" and department "MAC" and email "ninadev@ime.usp.br"
        And there is a hiper_professor with name "Zara" and password "changeme!" nusp "99986" department "MAT" and email "zaradev@ime.usp.br"
        And there is a request for teaching assistant by professor "Dude" for the course "MAC0110"
        And there is a request for teaching assistant by professor "Gold" for the course "MAC0431"
        And there is a request for teaching assistant by professor "Silver" for the course "MAT0125"
        And there is an assistant role for student "Bob" with professor "Dude" at course "MAC0110"

	Scenario: Student creates his assistant report
		Given I'm logged in as student "Bob"
		And I click the "Minhas candidaturas" link
		And I click the "Preencher relatório" link
		And I fill the "Quantos alunos em média você atendeu durante o plantão de monitores?" field with "2"
		And I fill the "Quantas listas de exercícios você corrigiu por mês (em média)?" field with "3"
		And I fill the "Você exerceu outra atividade além de atendimento a alunos e/ou correção de listas de exercícios?" field with "Aulas"
		And I choose the "2" workload option
		And I fill the "Por quê?" field with "Sim"
		And I fill the "Observações, sugestões e reclamações:" field with "Teste"
		And I press the "Enviar" button
		Then I should see "Ver relatório"

	Scenario: Secretary sees the button correctly
        Given I'm logged in as a secretary
        And there is an assistant role for student "John" with professor "Gold" at course "MAC0431" with a report
        And I click the "Monitores eleitos" link
        Then I should see "Bob MAC0110 Dude Desativar Atestado"
        Then I should see "John MAC0431 Gold Desativar Ver relatório Atestado"