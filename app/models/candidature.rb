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

  def self.for_course_in_semester course, semester
    candidatures_for_course = Candidature.where "semester_id = ? and (course1_id = ? or course2_id = ? or course3_id = ? or course4_id = ?)", semester.id, course.id, course.id, course.id, course.id
    current_requests = RequestForTeachingAssistant.where(semester: semester)
    current_roles = AssistantRole.where(request_for_teaching_assistant: current_requests)
    (candidatures_for_course.map do |candidature| candidature end).reject do |candidature|
      # Rejects if candidature's student already has a role this semester
      current_roles.where(student: candidature.student).any?
    end
  end

  def self.for_same_department_in_semester course, semester
    courses_in_same_department = Course.where "department_id = ? and id != ?", course.department_id, course.id
    candidatures_in_same_department = Candidature.where(course1_id: courses_in_same_department).where(semester: semester)
    current_requests = RequestForTeachingAssistant.where(semester: semester)
    current_roles = AssistantRole.where(request_for_teaching_assistant: current_requests)
    (candidatures_in_same_department.map do |candidature| candidature end).reject do |candidature|
      # Rejects if candidature's student already has a role this semester
      current_roles.where(student: candidature.student).any?
    end
  end

  def self.courses_num
    4
  end
end
