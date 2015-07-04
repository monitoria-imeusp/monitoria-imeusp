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

  def report_filled?
    !(report_creation_date.nil?)
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
      if active
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
