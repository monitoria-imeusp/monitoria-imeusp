Then(/^I should see "(.*?)"$/) do |text|
  page.should have_text(text)
end

Then(/^I should not see "(.*?)"$/) do |text|
  page.should_not have_text(text)
end
