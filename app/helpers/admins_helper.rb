module AdminsHelper
  def request_answer
    if @admin.registered_courses
      return "Disciplinas oferecidas no semestre inseridas com sucesso!"
    else
      return "Houve algum problema no cadastro das disciplinas a serem oferecidas. \nContacte o administrador do sistema."
    end
  end
end