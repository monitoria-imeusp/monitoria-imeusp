Given (/^I'm at the "(.*?)" page$/) do |page|
  visit page
end

Given(/^I'm at the login page$/) do
  visit new_admin_session_path
end

Then(/^I try the create course URL$/) do
  visit new_course_path
end

Then(/^I try the create secretary URL$/) do
  visit new_secretary_path
end

Given(/^I'm at the home page$/) do
  visit root_path
end

Given(/^I'm at the system access page$/) do
  visit "/sistema"
end

Given(/^I'm at the create_professors page$/) do
  visit new_professor_path
end

Given(/^I'm at the list_professors page$/) do
  visit professors_path
end

Given(/^I'm at the professor login page$/) do
  visit new_professor_session_path
end

Given(/^I'm at the secretary login page$/) do
  visit new_secretary_session_path
end

Given(/^I'm at the student login page$/) do
  visit new_student_session_path
end

When(/^I go to the new candidature form$/) do
  visit new_candidature_path(Semester.first.id)
end

When(/^I go to the new request form$/) do
  visit new_request_for_teaching_assistant_path(Semester.first.id)
end

When(/^I try to access the "(.*?)" page with id "(.*?)" to "(.*?)"$/) do |page_name, id, action|
    if action != 'show'
        visit('/' + page_name + '/' + id.to_s + '/' + action)
    else
        visit('/' + page_name + '/' + id.to_s)
    end
end

When(/^I try to update the student with id "(.*?)"$/) do |id|
    page.driver.put('/students/' + id.to_s)
end
