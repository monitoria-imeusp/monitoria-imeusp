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

  def normal_professor?
    return professor_rank == 0
  end

  def super_professor?
		return professor_rank > 0
  end

	def hiper_professor?
		return professor_rank == 2
  end
end
