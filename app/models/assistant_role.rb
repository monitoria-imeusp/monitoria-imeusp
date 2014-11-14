class AssistantRole < ActiveRecord::Base
  include ActiveModel::Validations
  validates :student_id, presence: true
  validates :request_for_teaching_assistant_id, presence: true
  belongs_to :student
  belongs_to :request_for_teaching_assistant
  has_one :assistant_evaluation
end
