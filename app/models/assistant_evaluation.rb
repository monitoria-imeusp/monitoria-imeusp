class AssistantEvaluation < ActiveRecord::Base
  include ActiveModel::Validations
  validates :assistant_role_id, presence: true
  validates :ease_of_contact, presence: true, inclusion: { in: 0..2 }
  validates :efficiency, presence: true, inclusion: { in: 0..2 }
  validates :reliability, presence: true, inclusion: { in: 0..2 }
  validates :overall, presence: true, inclusion: { in: 0..2 }
  belongs_to :assistant_role

  def semester
    assistant_role.semester
  end

  def professor
    assistant_role.professor
  end

  def student
    assistant_role.student
  end

  def course
    assistant_role.course
  end

  def self.request_evaluations_for_semester semester
    semester.open_evaluation_period
    professors = []
    requests = RequestForTeachingAssistant.where(semester: semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      professors.push(assistant.professor)
    end
    professors.uniq.each do |professor|
        NotificationMailer.evaluation_request_notification(professor, semester).deliver
    end
  end

end
