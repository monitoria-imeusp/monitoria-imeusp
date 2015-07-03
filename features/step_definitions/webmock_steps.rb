
Given(/^the undergraduate student with nusp "(.*?)" has valid history$/) do |nusp|
  stub_request(:any, (ENV["HISTORY_REQUEST_URL"].to_s)+"#{nusp}").to_return(:status => 200, :body => 
  {
    "historico" => [{"coddis" => "MAC0315","nota" => "5.0","rstfim" => "A ","codtur" => "20151"},
                    {"coddis" => "MAC0300","nota" => "0.0","rstfim" => "MA","codtur" => "20152"},
                    {"coddis" => "MAC0323","nota" => "0.0","rstfim" => "T ","codtur" => "20151"},
                    {"coddis" => "MAC0420","nota" => "9.0","rstfim" => "RF","codtur" => "20151"},
                    {"coddis" => "MAC0420","nota" => "4.9","rstfim" => "RN","codtur" => "20141"},
                    {"coddis" => "MAT0111","nota" => "3.0","rstfim" => "RA","codtur" => "20121"}]
    }.to_json, :headers => {})
end

Given(/^the graduate student with nusp "(.*?)" has valid history$/) do |nusp|
  stub_request(:any, (ENV["HISTORY_REQUEST_URL"].to_s)+"#{nusp}").to_return(:status => 200, :body => 
  {
    "historico" => [{"coddis" => "MAC5786","nota" => "A ","codtur" => "20151"},
                    {"coddis" => "MAC5714","nota" => "B ","codtur" => "20152"},
                    {"coddis" => "MAC5915","nota" => "C ","codtur" => "20151"},
                    {"coddis" => "MAC5716","nota" => "A ","codtur" => "20151"},
                    {"coddis" => "MAC6711","nota" => "A ","codtur" => "20141"},
                    {"coddis" => "MAT4578","nota" => "A ","codtur" => "20121"}]
    }.to_json, :headers => {})
end

Given(/^I can do real web requests$/) do
  #WebMock.disable!
end

Given(/^I can't do real web requests$/) do
  #WebMock.enable!
end