Given(/^I'm at the login page$/) do
      visit new_admin_session_path
end

Then(/^I try the create course URL$/) do
  visit new_course_path
end

Given(/^I'm at the home page$/) do
  visit root_path
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

Given(/^I'm at the professor login page$/) do
  visit new_professor_session_path
end

Given(/^[Tt]here is a professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  Professor.create(name: name , password: password, nusp: nusp, department: department, email: email)
end

When(/^I select the "(.*?)" option$/) do |option|
  choose(option, visible: false)
end

When(/^I mark the "(.*?)" checkbox$/) do |checkbox|
  check(checkbox)
end


Given(/^There is a super_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  Professor.create(name: name , password: password, nusp: nusp, department: department, email: email, super_professor: true)
end

When(/^There is a course with name "(.*?)" and code "(.*?)"$/) do |name, code|
  Course.create(name: name, course_code: code)
end
