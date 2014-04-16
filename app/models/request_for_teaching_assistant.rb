class RequestForTeachingAssistant < ActiveRecord::Base
  include ActiveModel::Validations
  validates :professor_id, presence: true
  validates :subject, presence: true
  validates :requestedNumber, presence: true, inclusion: { in: 1..32 }
  validates :priority, presence: true, inclusion: { in: 0..2 }
  validates :student_assistance, presence: true
  validates :work_correction, presence: true
  validates :test_oversight, presence: true
end
