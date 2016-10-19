class AssistantRole < ActiveRecord::Base
  include ActiveModel::Validations
  validates :student_id, presence: true
  validates :request_for_teaching_assistant_id, presence: true
  belongs_to :student
  belongs_to :request_for_teaching_assistant
  has_one :assistant_evaluation
  has_many :assistant_frequency

  def semester
    request_for_teaching_assistant.semester
  end

  def professor
    request_for_teaching_assistant.professor
  end

  def course
    request_for_teaching_assistant.course
  end

  def deactivate
    update_column(:active, false)
  end

  def reactivate
    update_column(:active, true)
  end

  def update_date_start_end(started_date, finished_date)
    update_column(:started_at, :started_date)
    update_column(:finished_at, :finished_date)
  end
  
  def report_filled?
    !(report_creation_date.nil?)
  end

  def frequency_for_month month
    assistant_frequency.where(month: month).take
  end

  def standard_first_day
    DateTime.new(semester.year, semester.months[0], 1)
  end

  def month_presence month
    first = DateTime.new(semester.year, month, 1)
    last = DateTime.new(semester.year, month, -1)
    if started_at > first and started_at < last then
      100*((last - started_at.to_datetime)/(last - first)).to_f
    else
      nil
    end
  end

  def self.for_semester semester
    (where request_for_teaching_assistant: (RequestForTeachingAssistant.where semester: semester)).sort do |role1, role2|
      role1.student.name <=> role2.student.name
    end
  end

  def self.for_professor_and_semester professor, semester
    (where request_for_teaching_assistant: (RequestForTeachingAssistant.where professor: professor, semester: semester)).sort do |role1, role2|
      role1.student.name <=> role2.student.name
    end
  end

  def self.for_department_and_semester department, semester
    (where request_for_teaching_assistant: (RequestForTeachingAssistant.where semester: semester, course: (Course.where department: department))).sort do |role1, role2|
      role1.student.name <=> role2.student.name
    end
  end

  def self.all_current
    semester = Semester.current
    requests = RequestForTeachingAssistant.where(semester: semester)
    AssistantRole.where(request_for_teaching_assistant: requests, active: true)
  end

  def self.pending_for_month month
    all_current.select do |role|
      AssistantFrequency.where(month: month, assistant_role: role).empty?
    end
  end

  def frequency_status_for_month month
    found = false
    assistant_frequency.each do |freq|
      if month == freq.month
        found = true
        if freq.presence
          if freq.payment
            return "Pago"
          end
          return "Presente"
        else
          return "Ausente"
        end
      end
    end
    if !found
      if active and semester.frequency_open?(Semester.month_to_period month)
        return "Pendente"
      else
        return "---"
      end
    end
  end

  def frequency_status_for_period period
    found = false
    assistant_frequency.each do |freq|
      if freq.semester.months[period] == freq.month
        found = true
        if freq.presence
          if freq.payment
            return "Pago"
          end
          return "Presente"
        else
          return "Ausente"
        end
      end
    end
    if !found
      if active and semester.frequency_open?(period)
        return "Pendente"
      else
        return "---"
      end
    end
  end

  def frequency_status_for_month_as_number month
    found = false
    assistant_frequency.each do |freq|
      if month == freq.month
        found = true
        if freq.presence
          return 3
        else
          return 1
        end
      end
    end
    if !found
      return 2
    end
  end

end
