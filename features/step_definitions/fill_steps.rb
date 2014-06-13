When(/^I fill the "(.*?)" field with "(.*?)"$/) do |field_name, value|
  fill_in field_name, :with => value
end

When(/^I write on the "(.*?)" text area "(.*?)"$/) do |text_area_name, text|
  fill_in text_area_name, :with => text
end
