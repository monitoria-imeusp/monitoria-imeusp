class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :registered_courses

  # def initialize
  #   @registered_courses = false
  # end

  def gather_undergrad_courses
    department = Mechanize.new
    course = Mechanize.new
    agent = Mechanize.new

    institute = agent.get('https://uspdigital.usp.br/jupiterweb/jupDepartamentoLista?codcg=45&tipo=D')
    departments = institute.parser.css('table')[3].css('tr')
    departments.shift
    departments_courses = []
    courses_codes = Hash.new(0)
    courses_names = []

    departments.each { |dep_element| departments_courses << dep_element.css('td')[1].children[1].attributes['href'].value }

    departments_courses.each do |department_link|
      department.get("https://uspdigital.usp.br/jupiterweb/#{department_link}")
      courses = department.page.parser.css('table a')
      courses.shift
      courses.pop
      courses.pop

      courses.each do |discpl_element|
        link_discpl = discpl_element.attributes['href'].value
        course.get("https://uspdigital.usp.br/jupiterweb/#{link_discpl}")
        classes_page = course.page.parser.css('table')[1].css('a').last['href']
        course.get("https://uspdigital.usp.br/jupiterweb/#{classes_page}")

        if course.page.parser.css('div#web_mensagem').css('p').text.match(/Não existe oferecimento para a sigla/) == nil
          course_code = course.page.parser.css('b')[3].text.match(/([A-Z]{3}[0-9]{4})[\s\-]*(([[:alpha:][:digit:]\-,:]+ ?)+)/)[1]
          courses_codes[course_code] += 1
          if courses_codes[course_code] == 1
            course_name = course.page.parser.css('b')[3].text.match(/([A-Z]{3}[0-9]{4})[\s\-]*(([[:alpha:][:digit:]\-,:]+ ?)+)/)[2]
            courses_names << course_name
          end
        end
      end
    end

    courses_codes.each_with_index do |course_code, index|
      if course_code[1] > 1
        Course.create({educational_level: 0,
                      name: courses_names[index],
                      course_code: course_code[0],
                      department: Department.find_by(:code => "INTERDEPARTMENTAL")})
      else
        department_code = course_code[0].match(/[A-Z]{3}/).to_s
        Course.create({educational_level: 0,
                      name: courses_names[index],
                      course_code: course_code[0],
                      department: Department.find_by(:code => department_code)})
      end
    end
  end

  def gather_postgrad_courses
    agent = Mechanize.new
    department = Mechanize.new

    # Tem que instanciar duas vezes para funcionar. Caso contrário o mechanize recebe uma página de sugestão de mudança de browser
    institute = agent.get('https://uspdigital.usp.br/janus/componente/catalogoDisciplinasInicial.jsf?action=4&tipo=D&codcpg=45')
    institute = agent.get('https://uspdigital.usp.br/janus/componente/catalogoDisciplinasInicial.jsf?action=4&tipo=D&codcpg=45')
    institute_deps = institute.iframe_with(:id => 'casca')
    departments = institute_deps.click
    departments.links.shift
    departments_courses = departments.links

    courses_codes = Hash.new(0)
    courses_names = []

    departments_courses.each do |department_link|
      department.get("https://uspdigital.usp.br/janus/#{department_link.href}")
      courses = department.page.parser.css('table[class="dataTable selecionavel"] tr')
      courses.shift
      courses.each do |discpl_element|
        course_code = discpl_element.css('td')[0].text
        courses_codes[course_code] += 1
        if courses_codes[course_code] == 1
          course_name = discpl_element.css('td')[1].text.match(/([[:alpha:][:digit:]\-,:]+ ?)+/)[0]
          courses_names << course_name
        end
      end
    end

    courses_codes.each_with_index do |course_code, index|
      if course_code[1] > 1
        Course.create({
                      educational_level: 1,
                      name: courses_names[index],
                      course_code: course_code[0],
                      department: Department.find_by(:code => "INTERDEPARTMENTAL")
                      })
      else
        department_code = course_code[0][0..2]
        Course.create({
                      educational_level: 1,
                      name: courses_names[index],
                      course_code: course_code[0],
                      department: Department.find_by(:code => department_code)
                      })
      end
    end
  end

end

