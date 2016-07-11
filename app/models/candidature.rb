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

  def self.all_first_options_for_request request
    chosen_roles = AssistantRole.where(request_for_teaching_assistant: request, active: true)
    chosen_student_ids = chosen_roles.all.map do |role| role.student.id end
    where("semester_id = ? and course1_id = ?", request.semester.id, request.course.id).where.not(student_id: chosen_student_ids)
  end

  def self.all_nonfirst_options_for_request request
    chosen_roles = AssistantRole.where(request_for_teaching_assistant: request, active: true)
    chosen_student_ids = chosen_roles.all.map do |role| role.student.id end
    where("semester_id = ? and (course1_id != ? and (course2_id = ? or course3_id = ? or course4_id = ?))", request.semester.id, request.course.id, request.course.id, request.course.id, request.course.id).where.not(student_id: chosen_student_ids)
  end

  def self.all_for_same_department_request request
    chosen_roles = AssistantRole.where(request_for_teaching_assistant: request, active: true)
    chosen_student_ids = chosen_roles.all.map do |role| role.student.id end
    courses_in_same_department = Course.where "department_id = ? and id != ?", request.course.department_id, request.course.id
    candidatures_in_same_department1 = Candidature.where(course1_id: courses_in_same_department, semester: request.semester)
    candidatures_in_same_department2 = Candidature.where(course2_id: courses_in_same_department, semester: request.semester)
    candidatures_in_same_department3 = Candidature.where(course3_id: courses_in_same_department, semester: request.semester)
    candidatures_in_same_department4 = Candidature.where(course4_id: courses_in_same_department, semester: request.semester)
    where.not(student_id: chosen_student_ids).find_by_sql("#{candidatures_in_same_department1.to_sql} UNION #{candidatures_in_same_department2.to_sql} UNION #{candidatures_in_same_department3.to_sql} UNION #{candidatures_in_same_department4.to_sql}")
  end

  def self.courses_num
    4
  end
end
