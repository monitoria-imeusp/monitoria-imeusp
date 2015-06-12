Given(/^it's currently month (\d+)/) do |month|
	travel_to (Time.mktime(2015,month,1))
end

Then(/I'm back to current time/) do
	travel_back
end