class AssistantFrequency < ActiveRecord::Base
  include ActiveModel::Validations
  validates :assistant_role_id, presence: true
  validates :month, presence: true, inclusion: {in: 1..12}
  belongs_to :assistant_role

  def semester
  	assistant_role.semester
  end

  def professor
    assistant_role.professor
  end

  def pay_if_present
    if presence == true and payment != true
      update_column(:payment, true)
    end
  end

  def self.FILTER_ALL
    0
  end

  def self.FILTER_PENDING
    1
  end

  def self.FILTER_PRESENT
    2
  end

  def self.FILTER_ABSENT
    3
  end

  def self.FILTER_PAID
    4
  end

  def self.FILTERS
    ["Todo", "Pendente", "Presente", "Ausente", "Pago"]
  end

  def self.current_frequencies
    AssistantFrequency.where assistant_role: (AssistantRole.for_semester Semester.current)
  end

  def self.schedule_notifications period
    month = Semester.current.months[period]
    Delayed::Job.enqueue(FrequencyMailJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 20, 8, 0, 0).getutc)
    Delayed::Job.enqueue(FrequencyReminderJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 26, 8, 0, 0).getutc)
    Delayed::Job.enqueue(LastFrequencyReminderJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 30, 8, 0, -3).getutc)
    # NOTE: February is never included as for frequency, so there will always be a 30th day of the current onth
  end

  def self.notify_frequency
    professors = {}
    AssistantRole.all_current.each do |role|
      professors[role.professor] = [] unless professors.key? role.professor
      professors[role.professor].push role
    end
    professors.each do |professor, roles|
      NotificationMailer.frequency_request_notification(professor, roles).deliver
    end
    month = Time.now.month
    if (month != 6 && month != 11)
      schedule_notifications Semester.month_to_period(month + 1)
    end
  end

  def self.notify_frequency_reminder
    professors = {}
    students = {}
    AssistantRole.pending_for_month(Time.now.month).each do |role|
      professors[role.professor] = [] unless professors.key? role.professor
      professors[role.professor].push role
      students[role.student] = [] unless students.key? role.student
      students[role.student].push role
    end
    professors.each do |professor, roles|
      NotificationMailer.frequency_request_notification(professor, roles).deliver
    end
    students.each do |student, roles|
      NotificationMailer.pending_frequencies_notification(student, roles).deliver
    end
  end

  def self.notify_last_frequency_reminder
    notify_frequency_reminder
    Professor.where(:professor_rank => [1, 2]).each do |super_professor|
      pending_roles = []
      AssistantRole.pending_for_month(Time.now.month).each do |role|
        if role.course.department == super_professor.department
            pending_roles.push(role)
        end
      end
      if pending_roles.any?
        NotificationMailer.last_pending_frequencies_notification(pending_roles, super_professor).deliver         
      end
    end
  end

  def self.for_semester_and_month semester, month
    requests_for_semester = RequestForTeachingAssistant.where(semester: semester)
    roles_for_semester = AssistantRole.where(request_for_teaching_assistant: requests_for_semester)
    where(assistant_role: roles_for_semester, month: month)
  end

end
