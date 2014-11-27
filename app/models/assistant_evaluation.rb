class AssistantEvaluation < ActiveRecord::Base
  include ActiveModel::Validations
  validates :assistant_role_id, presence: true
  validates :ease_of_contact, presence: true, inclusion: { in: 0..2 }
  validates :efficiency, presence: true, inclusion: { in: 0..2 }
  validates :reliability, presence: true, inclusion: { in: 0..2 }
  validates :overall, presence: true, inclusion: { in: 0..2 }
  validates :comment, presence: true
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


end
