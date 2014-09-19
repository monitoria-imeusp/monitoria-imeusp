
Given(/^I'm logged in as the admin$/) do
  Admin.create(email: "kazuo@ime.usp.br", password: "admin123")
  visit new_admin_session_path
  fill_in "Email", :with => "kazuo@ime.usp.br"
  fill_in "Senha", :with => "admin123"
  click_button "Entrar"
end

Given(/^I'm logged in as a secretary$/) do
  Secretary.create(
    name: "Fabiane",
    nusp: "99999",
    email: "fabiane@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  visit new_secretary_session_path
  fill_in "Número USP", :with => "99999"
  fill_in "Senha", :with => "changeme!"
  click_button "Entrar"
end
