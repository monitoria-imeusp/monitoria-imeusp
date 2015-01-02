class Professor < ActiveRecord::Base

  has_many :request_for_teaching_assistant
  belongs_to :department
  belongs_to :user

  validates :department_id, presence: true

  def name
    return user.name
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
