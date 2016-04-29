class NotificationMailer < ActionMailer::Base
  default from: "sistemamonitoria@ime.usp.br"
  add_template_helper(ApplicationHelper)
  add_template_helper(AssistantRolesHelper)

  def acceptance_notification assistant
    @assistant = assistant
    mail(to: assistant.student.email, subject: "Inscrição monitoria")
  end

  def evaluation_request_notification professor, semester
    @semester = semester
    mail(to: professor.email, subject: "Avaliação de monitor(a)")
  end

  def frequency_request_notification professor, roles
    @professor = professor
    @roles = roles
    mail(to: professor.email, subject: "Frequência de monitor(es)")
  end

  def pending_frequencies_notification student, roles
    @student = student
    @roles = roles
    mail(to: student.email, subject: "Frequência(s) pendente(s) na monitoria")
  end

  def last_pending_frequencies_notification pending_roles, super_professor
    @super_professor = super_professor
    @pending_roles = pending_roles
    mail(to: super_professor.email, subject: "Professores com frequência pendente de monitor(es)")
  end

end
