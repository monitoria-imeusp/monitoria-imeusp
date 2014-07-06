class Course < ActiveRecord::Base
  has_many :request_for_teaching_assistant
  belongs_to :department

  validates :department_id, presence: true
  validates :educational_level, presence: true, inclusion: { in: 0..1 }

  def full_name
    course_code + " - " + name
  end
end
