When(/^I mark the "(.*?)" checkbox$/) do |checkbox|
  check(checkbox)
end

When(/^I unmark the "(.*?)" checkbox$/) do |checkbox|
  uncheck(checkbox)
end
