class Candidature < ActiveRecord::Base
  include ActiveModel::Validations
  validates :time_period_preference, presence: true
  validates :course1_id, presence: true
  validates :semester_id, presence: true
  belongs_to :student
  belongs_to :semester

  def main_department
    Course.where(id: course1_id).take.department
  end
end
