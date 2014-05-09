class RequestForTeachingAssistant < ActiveRecord::Base
  include ActiveModel::Validations
  validates :professor_id, presence: true
  validates :subject, presence: true
  validates :requested_number, presence: true, inclusion: { in: 1..32 }
  validates :priority, presence: true, inclusion: { in: 0..2 }
end
