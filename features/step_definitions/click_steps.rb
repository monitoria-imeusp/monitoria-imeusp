
When(/^I press the "(.*?)" button$/) do |button_name|
  click_button(button_name)
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link(link)
end

When(/^I click the first "(.*?)" link$/) do |link|
  click_link(link, :match => :first)
end

When(/^I click the second "(.*?)" link$/) do |link|
  all('a').select {|elt| elt.text == link }[1].click
end
