include RequestForTeachingAssistantsHelper
include StudentsHelper
include CandidaturesHelper

When(/^I select the "(.*?)" option$/) do |option|
  choose(option, visible: false)
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

When(/^I select "(.*?)" on the "(.*?)"$/) do |option, box|
  select(option, :from => box)
end
