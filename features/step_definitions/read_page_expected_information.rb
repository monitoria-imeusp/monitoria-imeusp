Then(/^I should see "(.*?)"$/) do |text|
  page.should have_text(text)
end

Then(/^I should not see "(.*?)"$/) do |text|
  page.should_not have_text(text)
end

Then (/^"(.*)" should appear before "(.*)"/) do |first_example, second_example|
  page.text.should match(/#{first_example}.*#{second_example}/)
end

Then (/^"(.*)" should not appear before "(.*)"/) do |first_example, second_example|
  page.text.should_not match(/#{first_example}.*#{second_example}/)
end

Then (/^"(.*)" elected status should be "(.*)"/) do |nusp, elected|
  page.body.should match(/#{nusp}[^r]*#{elected}/)
end

Then (/^"(.*)" active status should be "(.*)"/) do |name, active|
  page.body.should match(/#{name}[^r]*#{active}/)
end
