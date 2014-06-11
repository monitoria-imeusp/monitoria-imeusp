include RequestForTeachingAssistantsHelper
include StudentsHelper
include CandidaturesHelper

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

Given(/^there is an admin user with email "(.*?)" and password "(.*?)"$/) do |email, password|
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

Given(/^I'm at the list_professors page$/) do
  visit professors_path
end

Then(/^I should not see "(.*?)"$/) do |text|
  page.should_not have_text(text)
end

Given(/^I'm at the professor login page$/) do
  visit new_professor_session_path
end

Given(/^there is a professor with name "(.*?)" and email "(.*?)" password "(.*?)" department "(.*?)"$/) do |name, email, password, department|
  Professor.create(name: name, email: email, password: password, department: department)
end

Given(/^there is a professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  d = Department.find_by("code" => department)
  if not d
    d = Department.create! {{"code" => department}}
  end
  Professor.create(name: name , password: password, nusp: nusp, department_id: d.id, email: email)
end

When(/^I select the "(.*?)" option$/) do |option|
  choose(option, visible: false)
end

When(/^I mark the "(.*?)" checkbox$/) do |checkbox|
  check(checkbox)
end

When(/^I select the priority option "(.*?)"$/) do |radio_button_string|
  RequestForTeachingAssistantsHelper.priorityOptions.each do |priority_option|
    if priority_option[0] == radio_button_string
      choose("request_for_teaching_assistant_priority_" + priority_option[1].to_s)
    end
  end
end

When(/^I select the gender option "(.*?)"$/) do |radio_button_string|
  StudentsHelper.genderOptions.each do |gender_options|
    if gender_options[0] == radio_button_string
      choose("student_gender_" + gender_options[1].to_s)
    end
  end
end

When(/^I select the count option "(.*?)"$/) do |radio_button_string|
  StudentsHelper.yesOrNo.each do |yes_or_no|
    if yes_or_no[0] == radio_button_string
      choose("student_has_bank_account_" + yes_or_no[1].to_s)
    end
  end
end

When(/^I select the preference option "(.*?)"$/) do |radio_button_string|
  CandidaturesHelper.daytimePreference.each do |preference_options|
    if preference_options[0] == radio_button_string
      choose ("candidature_time_period_preference_" + preference_options[1].to_s)
    end
  end
end


Given(/^there is a request for teaching assistant with professor "(.*?)" and course "(.*?)" and requested_number "(.*?)" and priority "(.*?)" and student_assistance "(.*?)" and work_correction "(.*?)" and test_oversight "(.*?)"$/) do |professor_name, course_code, requested_number, priority, student_assistance, work_correction, test_oversight|
  RequestForTeachingAssistant.create(professor_id: Professor.where(name: professor_name).take.id, course_id: Course.find_by({:course_code => course_code}).id, requested_number: requested_number, priority: priority, student_assistance: student_assistance, work_correction: work_correction, test_oversight: test_oversight)
end

When(/^I unmark the "(.*?)" checkbox$/) do |checkbox|
  uncheck(checkbox)
end

When(/^I confirm the alert$/) do
  page.driver.accept_js_confirms!
end

When(/^I should see "(.*?)" in the alert$/) do |text|
  page.driver.alert_messages == text
end

Given(/^there is a super_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  d = Department.find_by("code" => department)
  if not d
    d = Department.create! {{"code" => department}}
  end
  Professor.create(name: name , password: password, nusp: nusp, department_id: d.id, email: email, super_professor: true)
end

When(/^there is a course with name "(.*?)" and code "(.*?)" and department "(.*?)"$/) do |name, code, department|
  Course.create(name: name, course_code: code, department_id: Department.find_by({:code => department}).id)
end

When(/^there is a secretary with name "(.*?)" and password "(.*?)" nusp "(.*?)" and email "(.*?)"$/) do |name, password, nusp, email|
  Secretary.create(name: name, nusp: nusp, email: email, password: password)
end

Given(/^I'm at the secretary login page$/) do
  visit new_secretary_session_path
end

When(/^I write on the "(.*?)" text area "(.*?)"$/) do |text_area_name, text|
  fill_in text_area_name, :with => text
end

When(/^there is a student with name "(.*?)" and password "(.*?)" and nusp "(.*?)" and gender "(.*?)" and rg "(.*?)" and cpf "(.*?)" and address "(.*?)" and district "(.*?)" and zipcode "(.*?)" and city "(.*?)" and state "(.*?)" and tel "(.*?)" and cel "(.*?)" and email "(.*?)" and has_bank_account "(.*?)"$/) do |name, password, nusp, gender, rg, cpf, adress, district, zipcode, city, state, tel, cel, email, has_bank_account|
  Student.create(name: name, password: password, nusp: nusp, gender: gender, rg: rg, cpf: cpf, adress: adress, city: city, district: district, zipcode: zipcode, city: city, state: state, tel: tel, cel: cel, email: email, has_bank_account: has_bank_account)
end

Given(/^I'm at the student login page$/) do
  visit new_student_session_path
end

Given(/^there is a department with code "(.*?)"$/) do |code|
  Department.create(code: code)
end

Given(/^there is an candidature with student "(.*?)" and first option "(.*?)" and second option "(.*?)" and third option "(.*?)" and availability for daytime "(.*?)" and availability for night time "(.*?)" and period preference "(.*?)"$/) do |student, course1, course2, course3, av_daytime, av_nighttime, period|
  Candidature.create(
    student_id: Student.where(name: student).take.id, 
    course1_id: Course.where(name: course1).take.id, 
    course2_id: Course.where(name: course2).take.id, 
    avaliability_daytime: av_daytime, 
    avaliability_night_time: av_nighttime, 
    time_period_preference: period)
end
