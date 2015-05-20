class AssistantFrequency < ActiveRecord::Base
  include ActiveModel::Validations
  validates :professor_id, presence: true
  validates :role_id, presence: true
  validates :month, presence: true, inclusion: {in: 1..12}
  belongs_to :assistant_role
  belongs_to :professor

  def semester
  	assistant_role.semester
  end

end
