Given(/^it's currently month (\d+)/) do |month|
	travel_to (Time.mktime(2015,month,1))
end

Given(/^month (\d+) of semester (\d+)\/(\d+) is open for frequency$/) do |month, semester, year|
  semester = Semester.where(year: year, parity: (semester.to_i - 1)).take
  semester.open_frequency_period(Semester.month_to_period(month.to_i))
end

Then(/I'm back to current time/) do
	travel_back
end