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
      user: {
        name: "Nina S. T. Hirata",
        nusp: "33333",
        email: "ninadev@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAC"),
        professor_rank: 1
      }
    },
    {
      user: {
        name: "Kunio Okuda",
        nusp: "22222",
        email: "kuniodev@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAC"),
        professor_rank: 1
      }
    },
    {
      user: {
        name: "Zara Issa Abud",
        nusp: "11111",
        email: "zaradev@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAT"),
        professor_rank: 2
      }
    },
    { 
      user: {
        name: "Gold",
        nusp: "84710",
        email: "goldboy@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAC"),
        professor_rank: 1
      }
    },    
    {
      user: {
        name: "Siméon Denis Poisson",
        nusp: "10101",
        email: "poissondev@1781.old",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAE")
      }
    },
    {
      user: {
        name: "George Bernard Dantzig",
        nusp: "20202",
        email: "dantzigdev@1914.old",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAP")
      }
    }, 
    {
      user: {
        name: "Eloi Medina Galego",
        nusp: "30303",
        email: "eloidev@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      professor: {
        department: Department.find_by(:code => "MAT"),
        professor_rank: 1
      }
    }
  ].each do |entry|
    user = User.create(entry[:user])
    entry[:professor][:user_id] = user.id
    Professor.create(entry[:professor])
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
    }, 
    {
      educational_level: 0,
      name: "Estrutura de dados",
      course_code: "MAC0323",
      department: Department.find_by(:code => "MAC")
    }, 
    {
      educational_level: 0,
      name: "Trabalho de formatura supervisionado",
      course_code: "MAC0499",
      department: Department.find_by(:code => "MAC")
    }
  ].each do |course|
    Course.create(course)
  end

  [
    {
      user: {
        name: "Jackção Souza",
        nusp: "242424",
        email: "jacks@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
        institute: "IME",
        gender: "1",
        rg: "456",
        cpf: "654",
        address: "R. Matão",
        district: "Butantã",
        zipcode: "000",
        city: "São Paulo",
        state: "São Paulo",
        tel: "1111111111",
        cel: "11122233344",
        has_bank_account: false
      }
    },
    {
      user: {
        name: "Zé Eduardo Ferreira",
        nusp: 100001,
        email: "zezinho@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    },
    {
      user: {
        name: "Jef Eduardo Ferreira",
        nusp: 100003,
        email: "jefdev@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    }, 
    {
      user: {
        name: "Jao Henrique Luciano",
        nusp: 100004,
        email: "jao@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    }, 
    {
      user: {
        name: "Zizao Chen Tin",
        nusp: 100005,
        email: "zizao@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    }, 
    {
      user: {
        name: "Leonardo Haddad",
        nusp: 100006,
        email: "leo@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    }, 
    {
      user: {
        name: "Bianca Similamore Sanches Bittencourt",
        nusp: 100007,
        email: "bia@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
        institute: "IME",
        gender: "0",
        rg: "123",
        cpf: "321",
        address: "R. Matão",
        district: "Butantã",
        zipcode: "000",
        city: "São Paulo",
        state: "São Paulo",
        tel: "1111111111",
        cel: "11122233344",
        has_bank_account: true
      }
    }, 
    {
      user: {
        name: "Alfredo Silverman",
        nusp: 100008,
        email: "silver@ime.usp.br",
        password: "changeme!",
        confirmed_at: Time.now
      },
      student: {
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
        has_bank_account: true
      }
    }     
  ].each do |entry|
    user = User.create(entry[:user])
    entry[:student][:user_id] = user.id
    Student.create(entry[:student])
  end

  Semester.create(
    year: "2014",
    parity: "0",
    open: "false",
    active: "true",
    created_at: Time.now,
    updated_at: Time.now
  )

  [
    {
      student_id: Student.first.id,
      course1_id: Course.first.id,
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },
    {
      student_id: "2",
      course1_id: "5",
      course2_id: "1",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },
    {
      student_id: "3",
      course1_id: "5",
      course2_id: "1",
      course3_id: "3",
      course4_id: "6", 
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },
    {
      student_id: "4",
      course1_id: "5",
      course2_id: "1",
      course3_id: "6",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },
    {
      student_id: "5",
      course1_id: "5",
      course2_id: "1",
      course3_id: "3",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },
    {
      student_id: "6",
      course1_id: "2",
      course2_id: "1",
      course3_id: "6",
      course4_id: "5",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },     
    {
      student_id: "7",
      course1_id: "2",
      course2_id: "3",
      course3_id: "1",
      course4_id: "5",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    }, 
    {
      student_id: "8",
      course1_id: "2",
      course2_id: "6",
      course3_id: "3",
      course4_id: "5",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    },     
    {
      student_id: "9",
      course1_id: "2",
      course2_id: "4",
      course3_id: "3",
      course4_id: "6",
      daytime_availability: true,
      nighttime_availability: false,
      time_period_preference: "0",
      semester_id: Semester.first.id
    }
  ].each do |candidature|
    Candidature.create(candidature)
  end

  [
    {
      professor_id: Professor.first.id,
      requested_number: 1,
      priority: 0,
      course_id: Course.first.id,
      semester_id: Semester.first.id
    },
    {
      professor_id: Professor.first.id,
      requested_number: 1,
      priority: 0,
      course_id: "5",
      semester_id: Semester.first.id
    }, 
    {
      professor_id: "2",
      requested_number: 1,
      priority: 0,
      course_id: "6",
      semester_id: Semester.first.id
    },     
    {
      professor_id: "3",
      requested_number: 1,
      priority: 0,
      course_id: "2",
      semester_id: Semester.first.id
    },     
    {
      professor_id: "4",
      requested_number: 3,
      priority: 0,
      course_id: "2",
      semester_id: Semester.first.id
    },      
    {
      professor_id: "5",
      requested_number: 1,
      priority: 0,
      course_id: "3",
      semester_id: Semester.first.id
    }
  ].each do |ta_request|
    RequestForTeachingAssistant.create(ta_request)
  end

  [
    {
      professor_id: Professor.first.id,
      requested_number: 1,
      priority: 0,
      course_id: Course.first.id,
      semester_id: Semester.first.id
    }
  ].each do |ta_request|
    RequestForTeachingAssistant.create(ta_request)
  end

  [
    {
      request_for_teaching_assistant_id: "1",
      student_id: "7"
    }, 
    {
      request_for_teaching_assistant_id: "2", 
      student_id: "7"
    }, 
    {
      request_for_teaching_assistant_id: "5",
      student_id: "8"
    }, 
    {
      request_for_teaching_assistant_id: "5",
      student_id: "6"
    }, 
    {
      request_for_teaching_assistant_id: "5",
      student_id: "7"
    }, {
      request_for_teaching_assistant_id: "6",
      student_id: "7"
    }
  ].each do |assistant_role|
  	  assistant_role["started_at"] = Time.new(2014, 3, 1)
      AssistantRole.create(assistant_role)
  end

  [
    {
      assistant_role_id: "1",
      month: "2",
      presence: true
    },
    {
      assistant_role_id: "1",
      month: "3",
      presence: true   
    },
    {
      assistant_role_id: "1",
      month: "4",
      presence: true   
    },
    {
      assistant_role_id: "1",
      month: "5",
      presence: false   
    },
    {
      assistant_role_id: "2",
      month: "2",
      presence: true
    },
    {
      assistant_role_id: "2",
      month: "3",
      presence: true   
    },
    {
      assistant_role_id: "2",
      month: "4",
      presence: true   
    },
    {
      assistant_role_id: "3",
      month: "2",
      presence: true
    },
    {
      assistant_role_id: "3",
      month: "3",
      presence: false   
    },
    {
      assistant_role_id: "3",
      month: "4",
      presence: true   
    }, 
    {
      assistant_role_id: "4",
      month: "2",
      presence: true
    },
    {
      assistant_role_id: "4",
      month: "3",
      presence: false   
    },
    {
      assistant_role_id: "4",
      month: "4",
      presence: true   
    },
    {
      assistant_role_id: "4",
      month: "5",
      presence: false   
    },
    {
      assistant_role_id: "5",
      month: "2",
      presence: true
    },
    {
      assistant_role_id: "5",
      month: "3",
      presence: true   
    },
    {
      assistant_role_id: "5",
      month: "4",
      presence: true   
    }
    ].each do |assistant_frequency|
      AssistantFrequency.create(assistant_frequency)
  end

  Secretary.create(
    name: "Marcia",
    nusp: "99999",
    email: "marcia@ime.usp.br",
    password: "changeme!",
    confirmed_at: Time.now
  )

  Advise.create(
    title: "Bem-vindo ao sistema de monitoria do IME-USP!",
    message: "Esse sistema gerencia o cadastro de monitores nas disciplinas ministradas por professores do instituto."
  )

end
