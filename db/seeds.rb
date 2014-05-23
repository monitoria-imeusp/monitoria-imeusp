# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'kazuo@ime.usp.br', password: 'admin123')

if Rails.env.development?
  [
    {
      name: "Nina S. T. Hirata",
      nusp: "33333",
      department: "MAC",
      email: "nina@ime.usp.br",
      super_professor: true,
      password: "changeme!"
    },
    {
      name: "Kunio Okuda",
      nusp: "22222",
      department: "MAC",
      email: "kunio@ime.usp.br",
      super_professor: true,
      password: "changeme!"
    },
    {
      name: "Zara Issa Abud",
      nusp: "11111",
      department: "MAT",
      email: "zara@ime.usp.br",
      super_professor: true,
      password: "changeme!"
    },
    {
      name: "Siméon Denis Poisson",
      nusp: "10101",
      department: "MAE",
      email: "poisson@1781.old",
      password: "changeme!"
    },
    {
      name: "George Bernard Dantzig",
      nusp: "20202",
      department: "MAP",
      email: "dantzig@1914.old",
      password: "changeme!"
    }
  ].each do |prof|
    Professor.create(prof)
  end
  [
    {
      name: "Introdução à Ciência da Computação",
      course_code: "MAC0110"
    },
    {
      name: "Cálculo I",
      course_code: "MAT0111"
    },
    {
      name: "Introdução à Probabilidade e Estatística I",
      course_code: "MAE0121"
    },
    {
      name: "Laboratório de Matemática Aplicada",
      course_code: "MAP0131"
    }
  ].each do |course|
    Course.create(course)
  end
  Secretary.create(name: "Marcia", nusp: "99999", email: "marcia@ime.usp.br", password: "changeme!")
end
Department.create(code: 'MAC')
Department.create(code: 'MAE')
Department.create(code: 'MAP')
Department.create(code: 'MAT')
