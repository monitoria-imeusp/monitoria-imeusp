class NotificationMailer < ActionMailer::Base
  default from: "sistemamonitoria@ime.usp.br"
  add_template_helper(ApplicationHelper)
  add_template_helper(AssistantRolesHelper)

  def acceptance_notification assistant
    @assistant = assistant
    mail(to: assistant.student.email, subject: "Inscrição monitoria")
  end

  def evaluation_request_notification assistant
    @assistant = assistant
    mail(to: assistant.professor.email, subject: "Avaliação de monitor(a)")
  end


  def frequency_request_notification professor
    @professor = professor
    mail(to: professor.email, subject: "Frequência de monitor(es)")
  end

end
