class Professor < ActiveRecord::Base
  has_many :request_for_teaching_assistant
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:nusp]
  belongs_to :department
  validates :department_id, presence: true
  validates :nusp, presence: true

  def super_professor?
	return professor_rank > 0
  end
end
