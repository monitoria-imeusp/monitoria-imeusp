Given(/^I'm logged in as the admin$/) do
  Admin.create(email: "kazuo@ime.usp.br", password: "admin123")
  visit new_admin_session_path
  fill_in "Email", :with => "kazuo@ime.usp.br"
  fill_in "Senha", :with => "admin123"
  click_button "Entrar"
end

Given(/^I'm logged in as a secretary$/) do
  Secretary.create(
    name: "Fabiane",
    nusp: "99999",
    email: "fabiane@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  visit new_secretary_session_path
  fill_in "Número USP", :with => "99999"
  fill_in "Senha", :with => "changeme!"
  click_button "Entrar"
end

Given(/^I'm logged in as a professor$/) do
  user = User.create(
    name: "Common Professor",
    nusp: "66666",
    email: "common@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  Professor.create(
    department_id: Department.first.id,
    professor_rank: 0,
    user_id: user.id
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => 66666,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in for the first time as a professor$/) do
  user = User.create(
    name: "Common Professor",
    nusp: "66666",
    email: "common@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  Professor.create(
    department_id: Department.first.id,
    professor_rank: 0,
    user_id: user.id,
    dirty: true
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => 66666,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as professor "(.*?)"$/) do |name|
  professor = User.where(name: name).take
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => professor.id,
    'provider' => :usp,
    "info" => {
      "nusp" => professor.nusp,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as a super professor$/) do
  user = User.create(
    name: "Super Professor",
    nusp: "77777",
    email: "super@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  Professor.create(
    department_id: Department.first.id,
    professor_rank: 1,
    user_id: user.id
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => user.nusp,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as super professor from the "(.*?)" department$/) do |dep|
  user = User.create(
    name: "Super Professor",
    nusp: "77777",
    email: "super@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  department = Department.where(code: dep).take
  Professor.create(
    department_id: department.id,
    professor_rank: 1,
    user_id: user.id
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => user.nusp,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as a hyper professor$/) do
  user = User.create(
    name: "Hyper Professor",
    nusp: "77778",
    email: "hyper@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
  Professor.create(
    department_id: Department.first.id,
    professor_rank: 2,
    user_id: user.id
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => user.nusp,
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as a student$/) do
  user = User.create(
    name: "Joao",
    password: "changeme!",
    email: "joao@ime.usp",
    nusp: "55555",
    confirmed_at: Time.now
  )
  Student.create(
    user_id: user.id,
    institute: "Instituto de Matemática e Estatística",
    gender: "1",
    rg: "1",
    cpf: "1",
    address: "IME",
    city: "São Paulo",
    district: "Butantã",
    zipcode: "0",
    state: "SP",
    tel: "1145454545",
    cel: "11985858585",
    has_bank_account: "true"
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => user.nusp,
      "link" => :student
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in for the first time as a student$/) do
  user = User.create(
    name: "Joao",
    password: "changeme!",
    email: "joao@ime.usp",
    nusp: "55555",
    confirmed_at: Time.now
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => user.id,
    'provider' => :usp,
    "info" => {
      "nusp" => user.nusp,
      "link" => :student
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as student "(.*?)"$/) do |name|
  student = User.where(name: name).take
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => student.id,
    'provider' => :usp,
    "info" => {
      "nusp" => student.nusp,
      "link" => :student
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I logged in as an unfinished student$/) do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => 999,
    'provider' => :usp,
    "info" => {
      "nusp" => "888883",
      "name" => "Joaquim",
      "email" => "j@ime.usp.br",
      "link" => :student
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I logged in as an unfinished professor$/) do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
    'uid' => 998,
    'provider' => :usp,
    "info" => {
      "nusp" => "888884",
      "name" => "Ernesto Birgin",
      "email" => "egb@ime.usp.br",
      "link" => :teacher
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end
