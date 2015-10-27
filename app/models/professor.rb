class Professor < ActiveRecord::Base

  has_many :request_for_teaching_assistant
  has_many :assistant_frequency
  belongs_to :department
  belongs_to :user

  validates :department_id, presence: true

  def name
    self[:name] or user.name
  end

  def email
    self[:email] or user.email
  end

  def nusp
    self[:nusp] or user.nusp
  end

  def dep_code
    department.code
  end

  def normal_professor?
    return professor_rank == 0
  end

  def super_professor?
		return professor_rank > 0
  end

	def hiper_professor?
		return professor_rank == 2
  end

  def currently_pending_frequencies
    roles = AssistantRole.for_professor_and_semester self, Semester.current
    roles.map { |x| x }.keep_if do |role|
      (role.frequency_status_for_month Time.now.month) == "Pendente"
    end
  end
end
