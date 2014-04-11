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

Given(/^I'm at the create_professors page$/) do
      visit new_professor_path
end

When(/^I select "(.*?)" on the "(.*?)"$/) do |option, box|
    select(option, :from => box)
end

Given(/^There is a professor with email "(.*?)" and password "(.*?)"$/) do |email, password|
    Professor.create(email: email, password: password)
end

Given(/^I'm at the list_professors page$/) do
      visit professors_path
end

Then(/^I should not see "(.*?)"$/) do |text|
     page.should_not have_text(text)
end
