class RequestForTeachingAssistant < ActiveRecord::Base
  include ActiveModel::Validations
  validates :priority, inclusion: { in: 0..2 }
end
