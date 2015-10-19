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

  def self.current_frequencies
    AssistantFrequency.where assistant_role: (AssistantRole.for_semester Semester.current)
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
    Delayed::Job.enqueue(FrequencyReminderJob.new, priority: 0, run_at: 11.days.from_now.getutc)
    if (Time.now.month != 6 && Time.now.month != 11)
      Delayed::Job.enqueue(FrequencyMailJob.new, priority: 0, run_at: 1.months.from_now.getutc)
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
