When(/^I fill the "(.*?)" field with "(.*?)"$/) do |field_name, value|
  fill_in field_name, :with => value
end

When(/^I write on the "(.*?)" text area "(.*?)"$/) do |text_area_name, text|
  fill_in text_area_name, :with => text
end

When(/^I fill the fields for student "(.*?)" with nusp "(.*?)" and email "(.*?)"$/) do |name, nusp, email|
  fill_in "Nome Completo", :with => name
  fill_in "Senha", :with => "changeme!"
  fill_in "Confirme a senha", :with => "changeme!"
  fill_in "Número USP", :with => nusp
  fill_in "E-mail", :with => email
  choose "student_institute_instituto_de_matemtica_e_estatstica"
  choose "student_gender_1"
  fill_in "RG", :with => "1"
  fill_in "CPF", :with => "1"
  fill_in "Endereço", :with => "IME"
  fill_in "Bairro", :with => "Butantã"
  fill_in "CEP", :with => "0"
  fill_in "Cidade", :with => "São Paulo"
  fill_in "Estado", :with => "SP"
  fill_in "Telefone residencial", :with => "1145454545"
  fill_in "Celular", :with => "11985858585"
  choose "student_has_bank_account_true"
end

When(/^I fill the assistant evaluation fields$/) do
  choose "assistant_evaluation_ease_of_contact_1"
  choose "assistant_evaluation_efficiency_1"
  choose "assistant_evaluation_reliability_1"
  choose "assistant_evaluation_overall_1"
  fill_in "Comentários", :with => "Sbrubles"
end

When(/^I choose the "(.*?)" workload option$/) do |workload|
  choose "assistant_role_workload_#{workload}"
end



