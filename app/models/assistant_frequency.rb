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

  def self.current_frequencies
  	full_list = AssistantFrequency.all
  	active_semester = Semester.current
  	full_list.select { |frequency| frequency.semester == active_semester }
  end

end
