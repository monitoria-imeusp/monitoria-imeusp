class Course < ActiveRecord::Base
    has_many :request_for_teaching_assistant
end
