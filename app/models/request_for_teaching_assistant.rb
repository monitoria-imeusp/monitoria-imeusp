class RequestForTeachingAssistant < ActiveRecord::Base
  include ActiveModel::Validations
  #include Devise::Controllers::Helpers
  validates :professor_id, presence: true
  validates :requested_number, presence: true, inclusion: { in: 1..32 }
  validates :priority, presence: true, inclusion: { in: 0..2 }
  validates :course_id, presence: true, exclusion: { in: 0..0, message: "Por favor, escolha uma disciplina válida." }
  validates :semester_id, presence: true
  belongs_to :course
  belongs_to :professor
  belongs_to :semester

  def can_be_changed_by? user
    semester.open or (semester.active and (user.is_a? Secretary or user.super_professor?))
  end

  def chosen_roles
    AssistantRole.where(request_for_teaching_assistant: self, active: true)
  end

  def complete?
    chosen_roles.count >= requested_number
  end

  def incomplete?
    chosen_roles.count < requested_number
  end

  def chosen_student_ids
    chosen_roles.all.map do |role| role.student.id end
  end

end
