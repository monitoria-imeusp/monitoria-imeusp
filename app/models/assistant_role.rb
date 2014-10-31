class AssistantRole < ActiveRecord::Base
  include ActiveModel::Validations
  validates :student_id, presence: true
  validates :request_id, presence: true
  belongs_to :request
end
