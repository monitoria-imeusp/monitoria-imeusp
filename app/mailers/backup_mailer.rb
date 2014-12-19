class BackupMailer < ActionMailer::Base
  default from: "sistemamonitoria@ime.usp.br"
  add_template_helper(ApplicationHelper)
  add_template_helper(CandidaturesHelper)
  add_template_helper(RequestForTeachingAssistantsHelper)

  def new_candidature candidature
    set_candidature_parameters(candidature)
    mail(to: log_mail, subject: log_subject_new_candidature)
  end

  def edit_candidature candidature
    set_candidature_parameters(candidature)
    mail(to: log_mail, subject: log_subject_edit_candidature)
  end

  def delete_candidature candidature
    @student = candidature.student
    mail(to: log_mail, subject: log_subject_delete_candidature)
  end

  def new_request_for_teaching_assistant request
    @request = request
    mail(to: log_mail, subject: log_subject_new_request_for_teaching_assistant)
  end

  def edit_request_for_teaching_assistant request
    @request = request
    mail(to: log_mail, subject: log_subject_edit_request_for_teaching_assistant)
  end

  private

  def log_mail
    "monitoria.log.imeusp@gmail.com"
  end

  def log_subject_new_candidature
    "Nova inscrição do aluno #{@student.name} (#{Time.now})"
  end

  def log_subject_edit_candidature
    "Mudança na inscrição do aluno #{@student.name} (#{Time.now})"
  end

  def log_subject_delete_candidature
    "Desistência da inscrição do aluno #{@student.name} (#{Time.now})"
  end

  def log_subject_new_request_for_teaching_assistant
    "Nova solicitação de monitor pelo(a) professor(a) #{@request.professor.name} (#{Time.now})"
  end

  def log_subject_edit_request_for_teaching_assistant
    "Mudança na solicitação de monitor pelo(a) professor(a) #{@request.professor.name} (#{Time.now})"
  end

  def set_candidature_parameters(candidature)
    @candidature = candidature
    @student = candidature.student
    @course1 = Course.find(candidature.course1_id).full_name
    if candidature.course2_id != nil
      @course2 = Course.find(candidature.course2_id).full_name
    end
    if candidature.course3_id != nil
      @course3 = Course.find(candidature.course3_id).full_name
    end
  end

end
