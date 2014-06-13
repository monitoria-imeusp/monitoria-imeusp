When(/^I press the "(.*?)" button$/) do |button_name|
  click_button(button_name)
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link(link)
end
