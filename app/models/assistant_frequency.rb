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
    month = Semester.current.months[period-1]
    Delayed::Job.enqueue(FrequencyMailJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 20, 0, 0, -3).getutc)
    Delayed::Job.enqueue(FrequencyReminderJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 26, 0, 0, -3).getutc)
    #Delayed::Job.enqueue(FrequencyReminderJob.new, priority: 0, run_at: DateTime.new(Time.now.year, month, 30, 0, 0, -3).getutc)
    # NOTE: February is never included as for frequency, so there will always be a 30th day of the current onth
  end

  def self.notify_frequency
    professors = []
    semester = Semester.current
    requests = RequestForTeachingAssistant.where(semester: semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      professors.push(assistant.professor)
    end
    professors.uniq.each do |professor|   
      NotificationMailer.frequency_request_notification(professor).deliver
    end
    if (Time.now.month != 6 && Time.now.month != 11)
      schedule_notifications Semester.month_to_period(Time.now.month + 1)
    end
  end

  def self.notify_frequency_reminder
    semester = Semester.current
    requests = RequestForTeachingAssistant.where(semester: semester)
    Professor.where(:professor_rank => [1, 2]).each do |super_professor|
      pending_roles = []
      AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
        if !AssistantFrequency.where(month: Time.now.month, assistant_role_id: assistant.id).any?
          if assistant.course.department == super_professor.department
              pending_roles.push(assistant)
          end
        end
      end        
      if !pending_roles.empty?
          NotificationMailer.pending_frequencies_notification(pending_roles, super_professor).deliver         
      end
    end
  end

  def self.for_semester_and_month semester, month
    requests_for_semester = RequestForTeachingAssistant.where(semester: semester)
    roles_for_semester = AssistantRole.where(request_for_teaching_assistant: requests_for_semester)
    where(assistant_role: roles_for_semester, month: month)
  end

end
