class Course < ActiveRecord::Base
    has_many :request_for_teaching_assistant
    belongs_to :department

    validates :department_id, presence: true
end
