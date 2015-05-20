class AssistantRole < ActiveRecord::Base
  include ActiveModel::Validations
  validates :student_id, presence: true
  validates :request_for_teaching_assistant_id, presence: true
  belongs_to :student
  belongs_to :request_for_teaching_assistant
  has_one :assistant_evaluation
  has_many :assistant_frequency

  def semester
    request_for_teaching_assistant.semester
  end

  def professor
    request_for_teaching_assistant.professor
  end

  def course
    request_for_teaching_assistant.course
  end
  
  def deactivate
    update_column(:active, false)
  end
end
