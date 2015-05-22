class Candidature < ActiveRecord::Base
  include ActiveModel::Validations
  validates :time_period_preference, presence: true
  validates :course1_id, presence: true
  validates :semester_id, presence: true
  belongs_to :student
  belongs_to :semester

  def main_department
    Course.where(id: course1_id).take.department
  end

  def courses
    [course(1), course(2), course(3), course(4)]
  end

  def course n
    id = send("course#{n}_id".to_sym)
    if Course.exists? id
      Course.find(id)
    else
      nil
    end
  end

  def has_repeated_courses
    non_nil_courses = []
    (1..4).each do |i|
      if course(i) != nil
        non_nil_courses.push(course(i))
      end
    end
    if non_nil_courses.uniq.length == non_nil_courses.length
      return false
    else
      return true
    end
  end
  
  def elected?
    current_requests = RequestForTeachingAssistant.where(semester: semester)
    current_roles = AssistantRole.where(request_for_teaching_assistant: current_requests)
    current_roles.where(student: student, active: true).any?
  end

  def self.for_course_in_semester course, semester, only_first_option
    if only_first_option
        candidatures_for_course = Candidature.where "semester_id = ? and course1_id = ?", semester.id, course.id
    else
        candidatures_for_course = Candidature.where "semester_id = ? and (course1_id != ? and (course2_id = ? or course3_id = ? or course4_id = ?))", semester.id, course.id, course.id, course.id, course.id
    end
  end

  def self.for_same_department_in_semester course, semester
    courses_in_same_department = Course.where "department_id = ? and id != ?", course.department_id, course.id
    candidatures_in_same_department = Candidature.where(course1_id: courses_in_same_department).where(semester: semester)
  end

  def self.courses_num
    4
  end
end
