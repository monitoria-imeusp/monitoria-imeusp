# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Admin.create(email: 'kazuo@ime.usp.br', password: 'admin123', )

Department.create(code: 'MAC')
Department.create(code: 'MAE')
Department.create(code: 'MAP')
Department.create(code: 'MAT')
Department.create(code: 'MPM')
Department.create(code: 'INTERDEPARTAMENTAL')

if Rails.env.development?
  [
    {
      name: "Nina S. T. Hirata",
      nusp: "33333",
      department: Department.find_by(:code => "MAC"),
      email: "nina@ime.usp.br",
      professor_rank: 1,
      password: "changeme!",
      confirmed_at: Time.now
    },
    {
      name: "Kunio Okuda",
      nusp: "22222",
      department: Department.find_by(:code => "MAC"),
      email: "kunio@ime.usp.br",
      professor_rank: 1,
      password: "changeme!",
      confirmed_at: Time.now
    },
    {
      name: "Zara Issa Abud",
      nusp: "11111",
      department: Department.find_by(:code => "MAT"),
      email: "zara@ime.usp.br",
      professor_rank: 2,
      password: "changeme!",
      confirmed_at: Time.now
    },
    {
      name: "Siméon Denis Poisson",
      nusp: "10101",
      department: Department.find_by(:code => "MAE"),
      email: "poisson@1781.old",
      password: "changeme!",
      confirmed_at: Time.now
    },
    {
      name: "George Bernard Dantzig",
      nusp: "20202",
      department: Department.find_by(:code => "MAP"),
      email: "dantzig@1914.old",
      password: "changeme!",
      confirmed_at: Time.now
    }
  ].each do |prof|
    Professor.create(prof)
  end

  [
    {
      educational_level: 0,
      name: "Introdução à Computação",
      course_code: "MAC0110",
      department: Department.find_by(:code => "MAC")
    },
    {
      educational_level: 0,
      name: "Cálculo I",
      course_code: "MAT0111",
      department: Department.find_by(:code => "MAT")
    },
    {
      educational_level: 0,
      name: "Introdução à Probabilidade e Estatística I",
      course_code: "MAE0121",
      department: Department.find_by(:code => "MAE")
    },
    {
      educational_level: 0,
      name: "Laboratório de Matemática Aplicada",
      course_code: "MAP0131",
      department: Department.find_by(:code => "MAP")
    },
    {
      educational_level: 1,
      name: "Tópicos em Computação Gráfica",
      course_code: "MAC6913",
      department: Department.find_by(:code => "MAC")
    }
  ].each do |course|
    Course.create(course)
  end

  [
    {
      name: "Will",
      nusp: "000000",
      institute: "IME",
      gender: "1",
      rg: "123",
      cpf: "321",
      address: "R. Matão",
      district: "Butantã",
      zipcode: "000",
      city: "São Paulo",
      state: "São Paulo",
      tel: "1111111111",
      cel: "11122233344",
      email: "kazuo@ime.usp.br",
      has_bank_account: true,
      password: "changeme!",
      confirmed_at: Time.now
    },
    {
      name: "Jackção",
      nusp: "242424",
      institute: "IME",
      gender: "0",
      rg: "456",
      cpf: "654",
      address: "R. Matão",
      district: "Butantã",
      zipcode: "000",
      city: "São Paulo",
      state: "São Paulo",
      tel: "1111111111",
      cel: "11122233344",
      email: "jacks@ime.usp.br",
      has_bank_account: false,
      password: "changeme!",
      confirmed_at: Time.now
    }
  ].each do |student|
    Student.create(student)
  end

  Semester.create(
    year: "2014",
    parity: "0",
    open: "true",
    created_at: Time.now,
    updated_at: Time.now
  )

  Candidature.create(
    student_id: Student.first.id,
    course1_id: Course.first.id,
    daytime_availability: true,
    nighttime_availability: false,
    time_period_preference: "0",
    semester_id: Semester.first.id
  )

  Secretary.create(
    name: "Marcia",
    nusp: "99999",
    email: "marcia@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )

  Advise.create(
    title: "Bem-vindo ao sistema de monitoria do IME-USP!"
    message: "Esse sistema gerencia o cadastro de monitores nas disciplinas ministradas por professores do instituto."
  )

end
