When(/^I confirm the alert$/) do
  page.driver.accept_js_confirms!
end

When(/^I should see "(.*?)" in the alert$/) do |text|
  page.driver.alert_messages == text
end
