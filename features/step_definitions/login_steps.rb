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
  Department.create(
    code: "MAC"
  )
  Professor.create(
    department_id: Department.first.id,
    professor_rank: 0,
    user_id: user.id
  )
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:usp , OmniAuth::AuthHash.new({
  'uid' => user.id,
  'provider' => :usp,
  "info" => {
    "nusp" => 66666,
    "link" => :teacher
  }}))
  visit "/users/auth/usp"
end

Given(/^I'm logged in as professor "(.*?)"$/) do |name|
  professor = User.where(name: name).take
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:usp, {
    :uid => professor.id,
    :info => {
      :nusp => professor.nusp,
      :name => professor.name,
      :email => professor.email,
      :link => :teacher
    }
  })
  visit "/users/auth/usp"
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
  visit new_user_session_path
  fill_in "Número USP", :with => "77777"
  fill_in "Senha", :with => "changeme!"
  click_button "Entrar"
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
  visit new_user_session_path
  fill_in "Número USP", :with => "55555"
  fill_in "Senha", :with => "changeme!"
  click_button "Entrar"
end
