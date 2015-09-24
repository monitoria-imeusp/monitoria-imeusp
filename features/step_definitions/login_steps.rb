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

def common_professor
  User.create(
    name: "Common Professor",
    nusp: "66666",
    email: "common@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
end

def common_student
  User.create(
    name: "Joao",
    password: "changeme!",
    email: "joao@ime.usp",
    nusp: "55555",
    confirmed_at: Time.now
  )
end

def super_professor
  User.create(
    name: "Super Professor",
    nusp: "77777",
    email: "super@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
end

def hyper_professor
  User.create(
    name: "Hyper Professor",
    nusp: "77778",
    email: "hyper@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )
end

def make_professor user_id, *args
  if args.any?
    opts = args.last
  else
    opts = {}
  end
  Professor.create(
    department_id: (opts[:department_id] or Department.first.id),
    professor_rank: (opts[:rank] or 0),
    user_id: user_id,
    dirty: (opts[:dirty] or false)
  )
end

def make_student user_id,*args
  if args.any?
    opts = args.last
  else
    opts = {}
  end
  Student.create(
    user_id: user_id,
    institute: (opts[:institute] or "Instituto de Matemática e Estatística"),
    gender: (opts[:gender] or "1"),
    rg: (opts[:rg] or "1"),
    cpf: (opts[:cpf] or "1"),
    address: (opts[:address] or "IME"),
    city: (opts[:city] or "São Paulo"),
    district: (opts[:district] or "Butantã"),
    zipcode: (opts[:zipcode] or "0"),
    state: (opts[:state]or "SP"),
    tel: (opts[:tel] or "1145454545"),
    cel: (opts[:cel] or "11985858585"),
    has_bank_account: (opts[:has_bank_account] or "true")
  )
end

def auth_sign_in user, link
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({
    uid: user.id,
    provider: :usp,
    info: {
      nusp: user.nusp,
      name: user.name,
      email: user.email,
      link: link
    }
  })
  visit "/users/auth/usp"
  OmniAuth.config.test_mode = false
end

Given(/^I'm logged in as a professor$/) do
  user = common_professor
  make_professor user.id
  auth_sign_in user, :teacher
end

Given(/^I'm logged in for the first time as a professor$/) do
  user = common_professor
  make_professor user.id, dirty: true
  auth_sign_in user, :teacher
end

Given(/^I'm logged in as professor "(.*?)"$/) do |name|
  professor = User.where(name: name).take
  auth_sign_in professor, :teacher
end

Given(/^I'm logged in as a super professor$/) do
  user = super_professor
  make_professor user.id, rank: 1
  auth_sign_in user, :teacher
end

Given(/^I'm logged in as super professor from the "(.*?)" department$/) do |dep|
  user = super_professor
  department = Department.where(code: dep).take
  make_professor user.id, rank: 1, department_id: department.id
  auth_sign_in user, :teacher
end

Given(/^I'm logged in as a hyper professor$/) do
  user = hyper_professor
  make_professor user.id, rank: 2
  auth_sign_in user, :teacher
end

Given(/^I'm logged in as a student$/) do
  user = common_student
  make_student user.id
  auth_sign_in user, :student
end

Given(/^I'm logged in for the first time as a student$/) do
  user = common_student
  auth_sign_in user, :student
end

Given(/^I'm logged in as student "(.*?)"$/) do |name|
  student = User.where(name: name).take
  auth_sign_in student, :student
end

#Given(/^I logged in as an unfinished student$/) do
#  OmniAuth.config.test_mode = true
#  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
#    'uid' => 999,
#    'provider' => :usp,
#    "info" => {
#      "nusp" => "888883",
#      "name" => "Joaquim",
#      "email" => "j@ime.usp.br",
#      "link" => :student
#    }
#  })
#  visit "/users/auth/usp"
#  OmniAuth.config.test_mode = false
#end

#Given(/^I logged in as an unfinished professor$/) do
#  OmniAuth.config.test_mode = true
#  OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new ({
#    'uid' => 998,
#    'provider' => :usp,
#    "info" => {
#      "nusp" => "888884",
#      "name" => "Ernesto Birgin",
#      "email" => "egb@ime.usp.br",
#      "link" => :teacher
#    }
#  })
#  visit "/users/auth/usp"
#  OmniAuth.config.test_mode = false
#end
