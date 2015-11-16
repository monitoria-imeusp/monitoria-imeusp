Given(/^there is an admin user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  Admin.create(email: email, password: password)
end

Given(/^there is a request for teaching assistant with professor "(.*?)" and course "(.*?)" and requested_number "(.*?)" and priority "(.*?)" and student_assistance "(.*?)" and work_correction "(.*?)" and test_oversight "(.*?)"$/) do |professor_name, course_code, requested_number, priority, student_assistance, work_correction, test_oversight|
  RequestForTeachingAssistant.create(
    professor_id: User.where(name: professor_name).take.professor.id,
    course_id: Course.find_by({:course_code => course_code}).id,
    requested_number: requested_number,
    priority: priority,
    student_assistance: student_assistance,
    work_correction: work_correction,
    test_oversight: test_oversight,
    semester_id: Semester.first.id )
end

When(/^there is a request for teaching assistant by professor "(.*?)" for the course "(.*?)"$/) do |professor_name, course_code|
  RequestForTeachingAssistant.create(
    professor_id: User.where(name: professor_name).take.professor.id,
    course_id: Course.find_by({:course_code => course_code}).id,
    requested_number: 1,
    priority: 1,
    student_assistance: false,
    work_correction: false,
    test_oversight: false,
    semester_id: Semester.first.id )
end

def create_professor(name, password, nusp, department, email, professor_rank)
  d = Department.find_by("code" => department)
  if not d
    d = Department.create! {{"code" => department}}
  end
  user = User.create(name: name , password: password, nusp: nusp, email: email, confirmed_at: Time.now)
  Professor.create(department_id: d.id, professor_rank: professor_rank, user_id: user.id)
end

Given(/^there is a professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 0)
end

When(/^there is a professor with name "(.*?)" and nusp "(.*?)" and department "(.*?)" and email "(.*?)"$/) do |name, nusp, department, email|
  create_professor(name, "password", nusp, department, email, 0)
end

Given(/^there is a super_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 1)
end

Given(/^there is a super_professor with name "(.*?)" and nusp "(.*?)" and department "(.*?)" and email "(.*?)"$/) do |name, nusp, department, email|
  create_professor(name, "password", nusp, department, email, 1)
end

Given(/^there is a hiper_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 2)
end

When(/^there is a secretary with name "(.*?)" and password "(.*?)" nusp "(.*?)" and email "(.*?)"$/) do |name, password, nusp, email|
  s = Secretary.create(name: name, nusp: nusp, email: email, password: password,
    confirmation_token:nil, confirmed_at: Time.now)
end


Given(/^there is a student with name "(.*?)" with nusp "(.*?)" and email "(.*?)"$/) do |name, nusp, email|
  user = User.create(name: name, password: "changeme!", email: email, nusp: nusp, confirmed_at: Time.now)
  Student.create(institute: "Instituto de Matemática e Estatística", gender: "1", rg: "1", cpf: "1",
    address: "IME", city: "São Paulo", district: "Butantã", zipcode: "0", state: "SP",
    tel: "1145454545", cel: "11985858585",
    has_bank_account: "true", user_id: user.id)
end

Given(/^there is a department with code "(.*?)"$/) do |code|
  Department.create(code: code)
end

Given(/^there is an candidature with student "(.*?)" and first option "(.*?)" and second option "(.*?)" and third option "(.*?)" and availability for daytime "(.*?)" and availability for night time "(.*?)" and period preference "(.*?)"$/) do |student, course1, course2, course3, av_daytime, av_nighttime, period|
  Candidature.create(
    student_id: User.where(name: student).take.student.id,
    course1_id: Course.where(name: course1).take.id,
    course2_id: Course.where(name: course2).take.id,
    semester_id: Semester.first.id,
    daytime_availability: av_daytime,
    nighttime_availability: av_nighttime,
    time_period_preference: period)
end

When(/^there is a candidature by student "(.*?)" for course "(.*?)"$/) do |student_name, course_code|
  course_id = Course.where(course_code: course_code).take.id
  student_id = User.where(name: student_name).take.student.id
  Candidature.create(
    student_id: student_id,
    course1_id: course_id,
    semester_id: Semester.first.id,
    daytime_availability: true,
    nighttime_availability: true,
    time_period_preference: 0)
end

When(/^there is a course with name "(.*?)" and code "(.*?)" and department "(.*?)"$/) do |name, code, department|
  Course.create(name: name, course_code: code, department_id: Department.find_by({:code => department}).id)
end

When(/^there is a closed semester "(.*?)" "(.*?)"$/) do |year, parity|
  Semester.create(year: year, parity: (parity.to_i-1), open: false, active: true)
end

When(/^there is a closed but active semester (\d+)\/(\d+)$/) do |year, parity|
  Semester.create(year: year, parity: (parity.to_i-1), open: false, active: true)
end

When(/^there is an open semester "(.*?)" "(.*?)"$/) do |year, parity|
  Semester.create(year: year, parity: (parity.to_i-1), open: true, active: true)
end

Given(/^there is an active semester "(.*?)" "(.*?)"$/) do |year, parity|
  Semester.create(year: year, parity: (parity.to_i-1), open: false, active: true)
end

Given(/^there is an active semester "(.*?)" "(.*?)" during evaluation period$/) do |year, parity|
  Semester.create(year: year, parity: (parity.to_i-1), open: false, active: true, evaluation_period: true)
end

When(/^there is an assistant role for student "(.*?)" with professor "(.*?)" at course "(.*?)"$/) do |student_name, professor_name, course_code|
  professor_id = User.where(name: professor_name).take.professor.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  AssistantRole.create(student_id: User.where(name: student_name).take.student.id, request_for_teaching_assistant_id: request_id)
end

When(/^there is an assistant role for student "(.*?)" with professor "(.*?)" at course "(.*?)" with a report$/) do |student_name, professor_name, course_code|
  professor_id = User.where(name: professor_name).take.professor.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  AssistantRole.create(student_id: User.where(name: student_name).take.student.id, request_for_teaching_assistant_id: request_id, report_creation_date: DateTime.now)
end

When(/^there is a deactivated assistant role for student "(.*?)" with professor "(.*?)" at course "(.*?)"$/) do |student_name, professor_name, course_code|
  professor_id = User.where(name: professor_name).take.professor.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  AssistantRole.create(student_id: User.where(name: student_name).take.student.id, request_for_teaching_assistant_id: request_id, active: false)
end

Given(/^there is an advise with title "(.*?)" and message "(.*?)" and urgency "(.*?)"$/) do |title, message, urgency|
  if Advise.any?
    order = Advise.all.order(:order).last.order
    Advise.create(title: title, message: message, advise_urgency: urgency, order: order)
  else
    Advise.create(title: title, message: message, advise_urgency: urgency, order: 0)
  end
end

When(/^there is an assistant evaluation for student "(.*?)" with professor "(.*?)" at course "(.*?)" as "(.*?)"$/) do |student_name, professor_name, course_code, comment|
  professor_id = User.where(name: professor_name).take.professor.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  student_id = User.where(name: student_name).take.student.id
  assistant_role_id = AssistantRole.where(student_id: student_id, request_for_teaching_assistant_id: request_id).take.id
  AssistantEvaluation.create(
    assistant_role_id: assistant_role_id,
    ease_of_contact: 1,
    efficiency: 1,
    reliability: 1,
    overall: 1,
    comment: comment
  )
end

When(/^there is an assistant frequency with month "(.*?)" with presence "(.*?)" for student "(.*?)" and professor "(.*?)" at course "(.*?)"$/) do |month, presence, student_name, professor_name, course_code |
  professor_id = User.where(name: professor_name).take.professor.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  student_id = User.where(name: student_name).take.student.id
  assistant_role_id = AssistantRole.where(student_id: student_id, request_for_teaching_assistant_id: request_id).take.id
  AssistantFrequency.create(
    assistant_role_id: assistant_role_id,
    month: month,
    presence: presence
  )
end
