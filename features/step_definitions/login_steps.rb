Given(/^I'm at the login page$/) do
      visit new_admin_session_path
end

Given(/^There is an admin user with email "(.*?)" and password "(.*?)"$/) do |email, password|
      Admin.create(email: email, password: password)
end

When(/^I fill the "(.*?)" field with "(.*?)"$/) do |field_name, value|
     fill_in field_name, :with => value
end

When(/^I press the "(.*?)" button$/) do |button_name|
     click_button(button_name)
end

Then(/^I should see "(.*?)"$/) do |text|
     page.should have_text(text)
end

When(/^I click the "(.*?)" link$/) do |link|
    click_link(link)
end
