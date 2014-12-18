class AssistantMailer < ActionMailer::Base
  default from: "sistemamonitoria@ime.usp.br"
  add_template_helper(ApplicationHelper)
  add_template_helper(AssistantRolesHelper)

  def acceptance_notification assistant
    @assistant = assistant
    mail(to: assistant.student.email, subject: "Inscrição monitoria")
  end

end
