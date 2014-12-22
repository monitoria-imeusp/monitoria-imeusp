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

  def delete_request_for_teaching_assistant request
    @request = request
    mail(to: log_mail, subject: log_subject_delete_request_for_teaching_assistant)
  end

  def new_assistant_role role, creator
    @student = role.student
    @request = role.request_for_teaching_assistant
    @creator = creator
    mail(to: log_mail, subject: log_subject_new_assistant_role)
  end

  def delete_assistant_role role, creator
    @student = role.student
    @request = role.request_for_teaching_assistant
    @creator = creator
    mail(to: log_mail, subject: log_subject_delete_assistant_role)
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

  def log_subject_delete_request_for_teaching_assistant
    "Cancelamento da solicitação de monitor pelo(a) professor(a) #{@request.professor.name} (#{Time.now})"
  end

  def log_subject_new_assistant_role
    if @student.is_female?
      "Monitora #{@student.name} eleita para professor(a) #{@request.professor.name} (#{Time.now})"
    else
      "Monitor #{@student.name} eleito para professor(a) #{@request.professor.name} (#{Time.now})"
    end
  end

  def log_subject_delete_assistant_role
    if @student.is_female?
      "Remoção da monitora #{@student.name} previamente eleita para professor(a) #{@request.professor.name} (#{Time.now})"
    else
      "Remoção do monitor #{@student.name} previamente eleito para professor(a) #{@request.professor.name} (#{Time.now})"
    end
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
