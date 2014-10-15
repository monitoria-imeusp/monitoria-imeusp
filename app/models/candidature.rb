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

  def courses
    [course(1), course(2), course(3), course(4)]
  end

  def course n
    id = send("course#{n}_id".to_sym)
    if Course.exists? id
      Course.find(id)
    else
      nil
    end
  end

  def self.courses_num
    4
  end
end
