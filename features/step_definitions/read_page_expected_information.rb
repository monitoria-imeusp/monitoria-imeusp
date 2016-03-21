Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_text(text)
end

Then(/^I should not see "(.*?)"$/) do |text|
  expect(page).not_to have_text(text)
end

Then (/^"(.*)" should appear before "(.*)"/) do |first_example, second_example|
  expect(page.text).to match(/#{first_example}.*#{second_example}/)
end

Then (/^"(.*)" should not appear before "(.*)"/) do |first_example, second_example|
  expect(page.text).not_to match(/#{first_example}.*#{second_example}/)
end

Then (/^"(.*)" elected status should be "(.*)"/) do |nusp, elected|
  expect(page.body).to match(/#{nusp}[^r]*#{elected}/)
end

Then (/^"(.*)" active status should be active/) do |name|
  expect(page.body).not_to have_css('li', text: /#{name}.*Desativado/m)
end

Then (/^"(.*)" active status should be deactivated/) do |name|
  expect(page.body).to have_css('li', text: /#{name}.*Desativado/m)
end
