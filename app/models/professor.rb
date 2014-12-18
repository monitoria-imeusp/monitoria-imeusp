class Professor < ActiveRecord::Base
	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
		:confirmable, :authentication_keys => [:nusp]

  has_many :request_for_teaching_assistant
  belongs_to :department

  validates :department_id, presence: true
  validates :nusp, presence: true, uniqueness: true

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
