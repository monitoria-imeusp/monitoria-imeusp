class AssistantEvaluation < ActiveRecord::Base
  include ActiveModel::Validations
  validates :assistant_role_id, presence: true
  validates [:ease_of_contact, :efficiency, :reliability, :overall], presence: true, inclusion: { in: 0..2 }
  validates :comment, presence: true
  belongs_to :assistant_role
end
