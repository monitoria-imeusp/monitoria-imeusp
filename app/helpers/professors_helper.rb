module ProfessorsHelper
	def professorRankOptions
    [
      ['Comum', 0],
      ['Membro da comissão de monitoria', 1],
      ['Chefe da comissão de monitoria', 2]
    ]
  end

  def can_promote?
    is_normal_professor = @professor.normal_professor?
    if user_signed_in?
      current_user.professor do |professor|
        is_normal_professor and ((professor.super_professor? and professor.department_id == @professor.department_id) or professor.hiper_professor?)
      end
    else
      false
    end
  end

end
