class BackupMailer < ActionMailer::Base
  default from: "sistemamonitoria@ime.usp.br"

  def new_candidature_mail(candidature)
    @candidature = candidature
    @student = candidature.student
    @course1 = Course.find(candidature.course1_id).full_name
    if candidature.course2_id != nil
      @course2 = Course.find(candidature.course2_id).full_name
    end
    if candidature.course3_id != nil
      @course3 = Course.find(candidature.course3_id).full_name
    end
    #@url  = 'http://example.com/login'
    mail(to: log_mail, subject: log_subject)
  end

  private

  def log_mail
    "monitoria.log.imeusp@gmail.com"
  end

  def log_subject
    "Candidature from #{@student.name} (#{Time.now})"
  end

end
