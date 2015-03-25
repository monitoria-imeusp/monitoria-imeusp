Given(/^I'm ready to receive email$/) do
	ActionMailer::Base.delivery_method = :test
	ActionMailer::Base.perform_deliveries = true
	ActionMailer::Base.deliveries.clear
end

When(/^I confirm the (.*?) edition with nusp "(.*?)" and password "(.*?)" and email "(.*?)" and sign in$/) do |class_name, nusp, password, user_email|
	class_name.capitalize!
	klass = Object.const_get(class_name)
	user = klass.find_by_nusp(nusp)
  user.should_not be_nil
	email = ActionMailer::Base.deliveries.first
  email.from.should == ["monitoria@ime.usp.br"]
  email.to.should == [user_email]
  m = email.body.match(/href="http:\/\/localhost:3000(\/.*?)"/)
  confirmation_link = m[1]
  visit confirmation_link
  fill_in "Número USP", :with => user.nusp
  fill_in "Senha", :with => password
  click_button("Entrar")
end

When(/^I confirm the (.*?) account with email "(.*?)" and sign in$/) do |class_name, user_email|
  class_name.capitalize!
  klass = Object.const_get(class_name)
  user = klass.find_by_email(user_email)
  user.should_not be_nil
  email = ActionMailer::Base.deliveries.first
  email.from.should == ["monitoria@ime.usp.br"]
  email.to.should == [user_email]
  m = email.body.match(/Sua senha de acesso é: <strong>(.*?)<\/strong>/)
  password = m[1]
  m = email.body.match(/href="http:\/\/localhost:3000(\/.*?)"/)
  confirmation_link = m[1]
  visit confirmation_link
  fill_in "Número USP", :with => user.nusp
  fill_in "Senha", :with => password
  click_button("Entrar")
end

When(/^I confirm the user account with email "(.*?)"$/) do |user_email|
  user = User.find_by_email(user_email)
  user.should_not be_nil
  email = ActionMailer::Base.deliveries.last
  email.from.should == ["monitoria@ime.usp.br"]
  email.to.should == [user_email]
  m = email.body.match(/href="http:\/\/localhost:3000(\/.*?)"/)
  confirmation_link = m[1]
  visit confirmation_link
end
