
def handle_js_confirm
  page.evaluate_script 'window.confirmMsg = null'
  page.evaluate_script 'window.confirm = function(msg) { window.confirmMsg = msg; return true; }'
  yield
  page.evaluate_script 'window.confirmMsg'
end

When(/^I click "(.*?)" and expect an alert message "(.*?)"$/) do |link,message|
	expect(handle_js_confirm do
  	click_link link
	end).to eq message 
end


When(/^I press the "(.*?)" button$/) do |button_name|
  click_button(button_name)
end

When(/^I press the first "(.*?)" button$/) do |button_name|
  click_button(button_name, match: :first )
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link(link)
end

When(/^I click the first "(.*?)" link$/) do |link|
  click_link(link, match: :first)
end

When(/^I click the second "(.*?)" link$/) do |link|
  all('a').select {|elt| elt.text == link }[1].click
end
